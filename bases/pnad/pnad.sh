#!/bin/bash
# Converte arquivos da PNAD de TXT sem delimitadores para CSV com delimitadores

# PNAD 2011 - PESSOA
cut -c1-4,5-6,7-12,13-15,16-17,18-18,19-20,21-22,23-26,27-29,30-30,31-31,32-32,33-33,34-34,35-35,36-37,38-38,39-39,40-40,41-41,42-42,43-43,44-44,45-45,46-46,47-48,49-49,50-50,51-51,52-52,53-53,54-54,55-55,56-56,57-58,59-60,61-61,62-62,63-63,64-64,65-65,66-66,67-67,68-68,69-69,70-70,71-71,72-72,73-74,75-75,76-76,77-77,78-78,79-80,81-81,82-82,83-83,84-84,85-85,86-86,87-87,88-88,89-89,90-90,91-91,92-92,93-93,94-97,98-102,103-103,104-107,108-112,113-113,114-114,115-126,127-127,128-139,140-140,141-141,142-143,144-144,145-146,147-147,148-148,149-149,150-150,151-151,152-152,153-156,157-161,162-163,164-164,165-165,166-166,167-167,168-168,169-169,170-170,171-181,182-188,189-189,190-200,201-207,208-208,209-219,220-226,227-227,228-228,229-229,230-230,231-231,232-242,243-249,250-250,251-261,262-268,269-269,270-280,281-287,288-288,289-289,290-290,291-291,292-292,293-293,294-294,295-295,296-296,297-297,298-298,299-299,300-300,301-301,302-302,303-303,304-304,305-305,306-306,307-307,308-308,309-309,310-310,311-311,312-312,313-313,314-314,315-315,316-316,317-317,318-318,319-319,320-320,321-332,333-333,334-345,346-346,347-347,348-348,349-349,350-350,351-351,352-352,353-353,354-355,356-356,357-357,358-359,360-361,362-362,363-363,364-365,366-366,367-367,368-368,369-369,370-370,371-371,372-375,376-380,381-382,383-383,384-384,385-385,386-386,387-387,388-388,389-389,390-390,391-391,392-392,393-393,394-394,395-396,397-398,399-399,400-400,401-401,402-403,404-407,408-412,413-413,414-414,415-415,416-416,417-417,418-418,419-419,420-431,432-432,433-444,445-445,446-446,447-447,448-449,450-450,451-462,463-463,464-475,476-476,477-477,478-478,479-479,480-481,482-482,483-483,484-484,485-486,487-488,489-492,493-497,498-498,499-499,500-500,501-501,502-502,503-503,504-504,505-505,506-506,507-507,508-509,510-510,511-511,512-512,513-514,515-526,527-528,529-540,541-542,543-554,555-556,557-568,569-570,571-582,583-584,585-596,597-598,599-610,611-612,613-624,625-625,626-626,627-628,629-630,631-632,633-634,635-635,636-636,637-638,639-640,641-641,642-642,643-643,644-645,646-649,650-650,651-651,652-653,654-655,656-656,657-657,658-658,659-660,661-662,663-664,665-665,666-666,667-668,669-669,670-670,671-672,673-674,675-675,676-676,677-677,678-678,679-680,681-682,683-684,685-696,697-708,709-720,721-732,733-744,745-746,747-748,749-749,750-750,751-755,756-760,761-761,762-762,763-763,764-765,766-777,778-779,780-780,781-781,782-782,783-783,784-784,785-796,797-804 --output-delimiter=';' PES2011.TXT > pnad11.csv

# PNAD 2012 - PESSOA
cut -c1-4,5-6,7-12,13-15,16-17,18-18,19-20,21-22,23-26,27-29,30-30,31-31,32-32,33-33,34-34,35-35,36-37,38-38,39-39,40-40,41-41,42-42,43-43,44-44,45-45,46-46,47-48,49-49,50-50,51-51,52-52,53-53,54-54,55-55,56-56,57-58,59-60,61-61,62-62,63-63,64-64,65-65,66-66,67-67,68-68,69-69,70-70,71-71,72-72,73-74,75-75,76-76,77-77,78-78,79-80,81-81,82-82,83-83,84-84,85-85,86-86,87-87,88-88,89-89,90-90,91-91,92-92,93-93,94-94,95-98,99-103,104-104,105-108,109-113,114-114,115-115,116-127,128-128,129-140,141-141,142-142,143-144,145-145,146-147,148-148,149-149,150-150,151-151,152-152,153-153,154-157,158-162,163-164,165-165,166-166,167-167,168-168,169-169,170-170,171-171,172-182,183-189,190-190,191-201,202-208,209-209,210-220,221-227,228-228,229-229,230-230,231-231,232-232,233-243,244-250,251-251,252-262,263-269,270-270,271-281,282-288,289-289,290-290,291-291,292-292,293-293,294-294,295-295,296-296,297-297,298-298,299-299,300-300,301-301,302-302,303-303,304-304,305-305,306-306,307-307,308-308,309-309,310-310,311-311,312-312,313-313,314-314,315-315,316-316,317-317,318-318,319-319,320-320,321-321,322-333,334-334,335-346,347-347,348-348,349-349,350-350,351-351,352-352,353-353,354-354,355-356,357-357,358-358,359-360,361-362,363-363,364-364,365-366,367-367,368-368,369-369,370-370,371-371,372-372,373-376,377-381,382-383,384-384,385-385,386-386,387-387,388-388,389-389,390-390,391-391,392-392,393-393,394-394,395-395,396-397,398-399,400-400,401-401,402-402,403-404,405-408,409-413,414-414,415-415,416-416,417-417,418-418,419-419,420-420,421-432,433-433,434-445,446-446,447-447,448-448,449-450,451-451,452-463,464-464,465-476,477-477,478-478,479-479,480-480,481-482,483-483,484-484,485-485,486-487,488-489,490-493,494-498,499-499,500-500,501-501,502-502,503-503,504-504,505-505,506-506,507-507,508-508,509-510,511-511,512-512,513-513,514-515,516-527,528-529,530-541,542-543,544-555,556-557,558-569,570-571,572-583,584-585,586-597,598-599,600-611,612-613,614-625,626-626,627-627,628-629,630-631,632-633,634-635,636-636,637-637,638-639,640-641,642-642,643-643,644-644,645-646,647-650,651-651,652-652,653-654,655-656,657-657,658-658,659-659,660-661,662-663,664-665,666-666,667-667,668-669,670-670,671-671,672-673,674-675,676-676,677-677,678-678,679-679,680-681,682-683,684-685,686-697,698-709,710-721,722-733,734-745,746-747,748-749,750-750,751-751,752-756,757-761,762-762,763-763,764-764,765-766,767-778,779-780,781-781,782-782,783-783,784-784,785-785,786-797,798-805 --output-delimiter=';' PES2012.TXT > pnad12.csv

# PNAD 2013 - PESSOA
cut -c1-4,5-6,7-12,13-15,16-17,18-18,19-20,21-22,23-26,27-29,30-30,31-31,32-32,33-33,34-34,35-35,36-37,38-38,39-39,40-40,41-41,42-42,43-43,44-44,45-45,46-46,47-48,49-49,50-50,51-51,52-52,53-53,54-54,55-55,56-56,57-58,59-60,61-61,62-62,63-63,64-64,65-65,66-66,67-67,68-68,69-69,70-70,71-71,72-72,73-74,75-75,76-76,77-77,78-78,79-80,81-81,82-82,83-83,84-84,85-85,86-86,87-87,88-88,89-89,90-90,91-91,92-92,93-93,94-94,95-95,96-96,97-97,98-98,99-99,100-103,104-108,109-109,110-113,114-118,119-119,120-120,121-132,133-133,134-145,146-146,147-147,148-149,150-150,151-152,153-153,154-154,155-155,156-156,157-157,158-158,159-162,163-167,168-169,170-170,171-171,172-172,173-173,174-174,175-175,176-176,177-187,188-194,195-195,196-206,207-213,214-214,215-225,226-232,233-233,234-234,235-235,236-236,237-237,238-248,249-255,256-256,257-267,268-274,275-275,276-286,287-293,294-294,295-295,296-296,297-297,298-298,299-299,300-300,301-301,302-302,303-303,304-304,305-305,306-306,307-307,308-308,309-309,310-310,311-311,312-312,313-313,314-314,315-315,316-316,317-317,318-318,319-319,320-320,321-321,322-322,323-323,324-324,325-325,326-326,327-338,339-339,340-351,352-352,353-353,354-354,355-355,356-356,357-357,358-358,359-359,360-361,362-362,363-363,364-365,366-367,368-368,369-369,370-371,372-372,373-373,374-374,375-375,376-376,377-377,378-381,382-386,387-388,389-389,390-390,391-391,392-392,393-393,394-394,395-395,396-396,397-397,398-398,399-399,400-400,401-402,403-404,405-405,406-406,407-407,408-409,410-413,414-418,419-419,420-420,421-421,422-422,423-423,424-424,425-425,426-437,438-438,439-450,451-451,452-452,453-453,454-455,456-456,457-468,469-469,470-481,482-482,483-483,484-484,485-485,486-487,488-488,489-489,490-490,491-492,493-494,495-498,499-503,504-504,505-505,506-506,507-507,508-508,509-509,510-510,511-511,512-512,513-513,514-515,516-516,517-517,518-518,519-520,521-532,533-534,535-546,547-548,549-560,561-562,563-574,575-576,577-588,589-590,591-602,603-604,605-616,617-618,619-630,631-631,632-632,633-634,635-636,637-638,639-640,641-641,642-642,643-644,645-646,647-647,648-648,649-649,650-651,652-655,656-656,657-657,658-659,660-661,662-662,663-663,664-664,665-666,667-668,669-670,671-671,672-672,673-674,675-675,676-676,677-678,679-680,681-681,682-682,683-683,684-684,685-686,687-688,689-690,691-702,703-714,715-726,727-738,739-750,751-752,753-754,755-755,756-756,757-761,762-766,767-767,768-768,769-769,770-771,772-783,784-785,786-786,787-787,788-788,789-789,790-790,791-802,803-810 --output-delimiter=';' PES2013.txt > pnad13.csv

# PNAD 2014 - PESSOA
cut -c1-4,5-6,7-12,13-15,16-17,18-18,19-20,21-22,23-26,27-29,30-30,31-31,32-32,33-33,34-34,35-35,36-37,38-38,39-39,40-40,41-41,42-42,43-43,44-44,45-45,46-46,47-48,49-49,50-50,51-51,52-52,53-53,54-54,55-55,56-56,57-58,59-60,61-61,62-62,63-63,64-64,65-65,66-66,67-67,68-68,69-69,70-70,71-71,72-72,73-74,75-75,76-76,77-77,78-78,79-80,81-81,82-82,83-83,84-84,85-85,86-86,87-87,88-88,89-89,90-90,91-91,92-92,93-93,94-94,95-95,96-96,97-97,98-98,99-99,100-103,104-108,109-109,110-113,114-118,119-119,120-120,121-132,133-133,134-145,146-146,147-147,148-149,150-150,151-152,153-153,154-154,155-155,156-156,157-157,158-158,159-162,163-167,168-169,170-170,171-171,172-172,173-173,174-174,175-175,176-176,177-187,188-194,195-195,196-206,207-213,214-214,215-225,226-232,233-233,234-234,235-235,236-236,237-237,238-248,249-255,256-256,257-267,268-274,275-275,276-286,287-293,294-294,295-295,296-296,297-297,298-298,299-299,300-300,301-301,302-302,303-303,304-304,305-305,306-306,307-307,308-308,309-309,310-310,311-311,312-312,313-313,314-314,315-315,316-316,317-317,318-318,319-319,320-320,321-321,322-322,323-323,324-324,325-325,326-326,327-327,328-328,329-329,330-330,331-331,332-332,333-333,334-334,335-335,336-336,337-337,338-349,350-350,351-362,363-363,364-364,365-365,366-366,367-367,368-368,369-369,370-370,371-372,373-373,374-374,375-376,377-378,379-379,380-380,381-382,383-383,384-384,385-385,386-386,387-387,388-388,389-392,393-397,398-399,400-400,401-401,402-402,403-403,404-404,405-405,406-406,407-407,408-408,409-409,410-410,411-411,412-413,414-415,416-416,417-417,418-418,419-420,421-424,425-429,430-430,431-431,432-432,433-433,434-434,435-435,436-436,437-448,449-449,450-461,462-462,463-463,464-464,465-466,467-467,468-479,480-480,481-492,493-493,494-494,495-495,496-496,497-498,499-499,500-500,501-501,502-503,504-505,506-509,510-514,515-515,516-516,517-517,518-518,519-519,520-520,521-521,522-522,523-523,524-524,525-526,527-527,528-528,529-529,530-531,532-543,544-545,546-557,558-559,560-571,572-573,574-585,586-587,588-599,600-601,602-613,614-615,616-627,628-629,630-641,642-642,643-643,644-645,646-647,648-649,650-651,652-652,653-653,654-655,656-657,658-658,659-659,660-660,661-662,663-666,667-667,668-668,669-670,671-672,673-673,674-674,675-675,676-677,678-679,680-681,682-682,683-683,684-685,686-686,687-687,688-689,690-691,692-692,693-693,694-694,695-695,696-697,698-699,700-701,702-713,714-725,726-737,738-749,750-761,762-763,764-765,766-766,767-767,768-772,773-777,778-778,779-779,780-780,781-782,783-794,795-796,797-797,798-798,799-799,800-800,801-801,802-813,814-814,815-816,817-817,818-819,820-820,821-821,822-825,826-830,831-831,832-832,833-833,834-834,835-835,836-837,838-838,839-839,840-840,841-841,842-842,843-843,844-847,848-852,853-853,854-854,855-855,856-856,857-857,858-859,860-860,861-861,862-862,863-863,864-864,865-865,866-869,870-874,875-875,876-876,877-877,878-882,883-887,888-895 --output-delimiter=';' PES2014.txt > pnad14.csv

# PNAD 2015 - PESSOA
cut -c1-4,5-6,7-12,13-15,16-17,18-18,19-20,21-22,23-26,27-29,30-30,31-31,32-32,33-33,34-34,35-35,36-37,38-38,39-39,40-40,41-41,42-42,43-43,44-44,45-46,47-47,48-48,49-49,50-50,51-51,52-52,53-53,54-54,55-56,57-58,59-59,60-60,61-61,62-62,63-63,64-64,65-65,66-66,67-67,68-68,69-69,70-70,71-72,73-73,74-74,75-75,76-76,77-78,79-79,80-80,81-81,82-82,83-83,84-84,85-85,86-86,87-87,88-88,89-89,90-90,91-91,92-92,93-96,97-101,102-102,103-106,107-111,112-112,113-113,114-125,126-126,127-138,139-139,140-140,141-142,143-143,144-145,146-146,147-147,148-148,149-149,150-150,151-151,152-155,156-160,161-162,163-163,164-164,165-165,166-166,167-167,168-168,169-169,170-180,181-187,188-188,189-199,200-206,207-207,208-218,219-225,226-226,227-227,228-228,229-229,230-230,231-241,242-248,249-249,250-260,261-267,268-268,269-279,280-286,287-287,288-288,289-289,290-290,291-291,292-292,293-293,294-294,295-295,296-296,297-297,298-298,299-299,300-300,301-301,302-302,303-303,304-304,305-305,306-306,307-307,308-308,309-309,310-310,311-311,312-312,313-313,314-314,315-315,316-316,317-317,318-318,319-319,320-331,332-332,333-344,345-345,346-346,347-347,348-348,349-349,350-350,351-351,352-352,353-354,355-355,356-356,357-358,359-360,361-361,362-362,363-364,365-365,366-366,367-367,368-368,369-369,370-370,371-374,375-379,380-381,382-382,383-383,384-384,385-385,386-386,387-387,388-388,389-389,390-390,391-391,392-392,393-393,394-395,396-397,398-398,399-399,400-400,401-402,403-406,407-411,412-412,413-413,414-414,415-415,416-416,417-417,418-418,419-430,431-431,432-443,444-444,445-445,446-446,447-448,449-449,450-461,462-462,463-474,475-475,476-476,477-477,478-478,479-480,481-481,482-482,483-483,484-485,486-487,488-491,492-496,497-497,498-498,499-499,500-500,501-501,502-502,503-503,504-504,505-505,506-506,507-508,509-509,510-510,511-511,512-513,514-525,526-527,528-539,540-541,542-553,554-555,556-567,568-569,570-581,582-583,584-595,596-597,598-609,610-611,612-623,624-624,625-625,626-627,628-629,630-631,632-633,634-634,635-635,636-637,638-639,640-640,641-641,642-642,643-644,645-648,649-649,650-650,651-652,653-654,655-655,656-656,657-657,658-659,660-661,662-663,664-664,665-665,666-667,668-668,669-669,670-671,672-673,674-674,675-675,676-676,677-677,678-679,680-681,682-683,684-695,696-707,708-719,720-731,732-743,744-745,746-747,748-748,749-749,750-754,755-759,760-760,761-761,762-762,763-764,765-776,777-778,779-779,780-780,781-781,782-782,783-783,784-795,796-803 --output-delimiter=';' PES2015.txt > pnad15.csv
