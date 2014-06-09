using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace SbirkaPrikladuEU.Class
{
    public static partial class TextTransform
    {
        public static string RemoveDiacritics(this String s)
        {
            if (s == null) return string.Empty;
            var normalizedString = s.Normalize(NormalizationForm.FormD);
            var stringBuilder = new StringBuilder();

            foreach (var c in normalizedString)
            {
                if (CharUnicodeInfo.GetUnicodeCategory(c) != UnicodeCategory.NonSpacingMark)
                    stringBuilder.Append(c);
            }

            return stringBuilder.ToString();
        }

        public static string RemoveHtmlTags(this String s)
        {
            s = Regex.Replace(s, @"<[^>]*>", String.Empty);
            return s;
        }
    }
}