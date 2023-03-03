Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A47D6A9D9F
	for <lists+linux-can@lfdr.de>; Fri,  3 Mar 2023 18:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCCR0a (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 3 Mar 2023 12:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCCR0a (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Mar 2023 12:26:30 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2092.outbound.protection.outlook.com [40.107.21.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62534D62F
        for <linux-can@vger.kernel.org>; Fri,  3 Mar 2023 09:26:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFle/SCvDfbLNZlSPgFJEzu370q/411/su7wD/1l0LNr1UguSDBxoIsOB/clKx/UFzRTif0SzDHR9sDPv00bVq7/wRlkpfIaIS5IB4r9DEpW82rF7kwy9aLnuRJGr8JdPumkuHewT7016QrnNUabQOEw0k6pEzdzYE+8esfZsLJl+t3dZPHd/OAJiWWPUViJtoixg/xQQAmJqa0Suu3bu2XDKt8N5atL3xXaBcxfIi6RLc3RjSaxGXn/6eXrH7UWcaP4lA0AwfxzEeVWog+3hqFrPJvX6Qc0uuUJQINJALjcqoiR5ifaDFYaukslPgGeLHLmdMxW9758gYF+N1FNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAgBCvoSw5aYyG65Wl0Ur4ubnLBb7NpXFpgpObsZcpk=;
 b=b141NiBWn3z+zXsbPUBXiS7uByLodHvHRAEwHcLQv/ojd6/lKtACQPVS8lrkURWHSsZjeShB1bS7iSzs5mw9CrnlOCnRrAHrA8F49zhi8SPSRtEO/6TbKXijVT5ZUbMVRNK45VlA6nIRYec4k8Ntuv4nU9XwEJhUFuWtEoo4q85TFAaJqYKYJijl1sXb0yA+w0IKGDr6TY1408sx7OkybKfOYnMDNEVw9VWOcOzCvmKlrxf3g9Ph6B5WW7+3gD/hqhLXYzynlHcDo7gfX9RaF7SRlkUvnXtbakRKGXJzTlPIYcz3XA5fihptzJIIvFoWcG/ozi1Ai0WvvSOXRgmpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cvut.cz; dmarc=pass action=none header.from=cvut.cz; dkim=pass
 header.d=cvut.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cvut.cz; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAgBCvoSw5aYyG65Wl0Ur4ubnLBb7NpXFpgpObsZcpk=;
 b=Er6Fyb1JFCpyypZWtqAiGHcMgvu6fdUEzcWRJWb3e0k8WwEFpgRyzvTFDPpwToZtJ6oiyUeni+6IlW4p84dvNcBUD5smBOnmKrhaYMlx5OLD9yD2feJSiWkHCcE+7xcRpcE6DcRoTb2cKRomvCp1fVfsuCrU9epW1sCZQgPIM6qLAoYn+ktRGCr2NypROq73a8hKq5XmWu4GVAjgfjC7l13EbWMKR23RxR3ILoSPuFnnLMDV1oIk2rkUohBlBczPjMS4ucKtp7tkY0P+iwx4H0hEFg3ow0GswXPqyEmU6K81rdWeO70s4ZrA1WObHr3MUr+gFjbHw+KZP5kEv9cn2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cvut.cz;
Received: from AM0PR06MB6548.eurprd06.prod.outlook.com (2603:10a6:208:195::14)
 by DB7PR06MB4281.eurprd06.prod.outlook.com (2603:10a6:5:2f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Fri, 3 Mar
 2023 17:26:26 +0000
Received: from AM0PR06MB6548.eurprd06.prod.outlook.com
 ([fe80::a3db:1265:91f3:b6fe]) by AM0PR06MB6548.eurprd06.prod.outlook.com
 ([fe80::a3db:1265:91f3:b6fe%3]) with mapi id 15.20.6156.021; Fri, 3 Mar 2023
 17:26:26 +0000
From:   Michal Sojka <michal.sojka@cvut.cz>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Jakub Jira <jirajak2@fel.cvut.cz>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: Lost packets on ISO-TP and vcan
In-Reply-To: <40f9aad6-81be-e442-2668-cb349fe7313f@hartkopp.net>
References: <b53a04a2-ba1f-3858-84c1-d3eb3301ae15@hartkopp.net>
 <878rghtt0p.fsf@steelpick.2x.cz>
 <08d8e225-0e7a-a75f-f8fa-e4a8ce99d4a4@hartkopp.net>
 <87zg8vjyqg.fsf@steelpick.2x.cz>
 <40f9aad6-81be-e442-2668-cb349fe7313f@hartkopp.net>
Date:   Fri, 03 Mar 2023 18:26:23 +0100
Message-ID: <87mt4tu4ow.fsf@steelpick.2x.cz>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::41) To AM0PR06MB6548.eurprd06.prod.outlook.com
 (2603:10a6:208:195::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR06MB6548:EE_|DB7PR06MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ade0a1-bc79-4ee4-d1c4-08db1c0c6a88
X-LD-Processed: f345c406-5268-43b0-b19f-5862fa6833f8,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTvhdjuQEuinP3N9a+POtqOxyXV/ck34QNsvpeUdwJhAIQxLjcauieN/ch+0O26reBS+EXpUIyjBpP0qIEFPhsJFnCzM5LT8mC65G0dwNxVUGm9oNmecAe2RjiGbsketwfwrY5oHJjuNzFU6xpaIqhvXvk7giDysHnPtHGtw/Qjxi2oL80nTs7OKZiOV3zfz68FGX/G4DtJyEi0YjHKfAdj7WNQXSDgDNeCS1A1FQmSe7UOEGtwfdKjlQaj/KLTX+e1MDIi/yug198LyQG0jR3coAUZqlPiFjxxAtFtDjmU9OGDU8QPnHqxR/av9xg8VOw+5OqcyhwErOaOLq7o7uUk1FEcYa09dT8qiMsOeE/xVgCfdTUCKjDa/yWzaKmZnQ/F36fPizSkFgjJQH9/VduG5q3U9GaB9VNMTipzYCVZiBs8qaF+P8xrrXU6ARMWYNMYVPTQnoL+5bLUCnWSohdwAWxc3/2RjxU+homCKnQY4VF1DxKb+AvnKu6Vo1MbuhX2Hj2BXLpPc4ol8UnxKoXUinRXJ9NtG3UD7GCgSaS29Kfmh4QAUup9eQluVvD3gqbGMFM7hemWGGrtHDQUokdhRGVa3MBHv9xxMzHehhda1+KFbgm4RSUtZLrfctI8hN7mKrwDB2mys9Q+A5OellQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB6548.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(346002)(396003)(39850400004)(451199018)(41320700001)(83380400001)(786003)(478600001)(110136005)(4326008)(8676002)(6506007)(66476007)(38100700002)(6512007)(26005)(9686003)(186003)(6486002)(6666004)(41300700001)(5660300002)(8936002)(66946007)(44832011)(66556008)(316002)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DZLRnP0Iomz1Uy/+WiaU9pYDcUC0sdI1mzGDwPRUyja1etYCW5sQ1RIB9it7?=
 =?us-ascii?Q?MD8P7S3VFksF1p1d3h+AqsYYMBbNQzfpAmbh6391lsbd/bE/hIyTZhMcNuHz?=
 =?us-ascii?Q?MuOZIMAMy0QuOhHORjC9DA2331DZEkHmX5t7sCd+i4T7tpPGSRNsLpbEq13z?=
 =?us-ascii?Q?REH+CcNBeddtER6ySjlm18AMkclDEdco0oAu0uZy05tORUDVGBkeraBGOUfN?=
 =?us-ascii?Q?JuKbCVmSL8h5dn/GDRSFPzLRjE5fY/gQcLRwuoDCF0pNc/Npgk3W2ReEiuc0?=
 =?us-ascii?Q?qb3DSVpmCwOE/He+UlEYqfbZ3QyXbhQUF+ZWR/J90Mb4OPGEDdEdezYPCXO4?=
 =?us-ascii?Q?JwDtESpwZNPLZfdPXh+q9yLBnihyYoIXIeghZ3YnHuHssuBC64cG3ihJaIg4?=
 =?us-ascii?Q?D7vZbFre7BQPtcQhkxpW6nzZFIYBPsZDPCpiw2ySW8JmlAN6u9aY8OEhrQl+?=
 =?us-ascii?Q?slg3KFoLDUlStxrXhMEvIWVWL9LYPBG8VHUWrfd2ouGcWAH4HUCByi6oZyeb?=
 =?us-ascii?Q?yW9ye//3yOYhXQiPfQ9rGMUDYZKcYcqBQpMtXP0kdlndBMqH5WP+3gIZdPVI?=
 =?us-ascii?Q?B7InBTcJPbA1qDzZ+EX9mPh7PCYk2RMLn2sL5Dn0tIGy/GrYRW6ERkTHPvjE?=
 =?us-ascii?Q?TyQyuzsWomJ22yLi1w75XQD6vz8FJJIjXDKy9PDNnzlP0rnfT0Yhh6DW952r?=
 =?us-ascii?Q?woWr5tWKq5NycnjQ8X6DaUNp4+CTfp19vuYxCBOjNh3+PDQmVrCv/BTHSVOM?=
 =?us-ascii?Q?dHtJuzYMLMw0QsK+StS68xHI04lAWLnjaKCW9qSml1zBgC8rI4mOrGmJmdrI?=
 =?us-ascii?Q?fX7SrvrnxdYij9rXkTzlvNmn6V7ForeAsO3SJB4A7S3I4FN8P/kMMjfFLFxC?=
 =?us-ascii?Q?iupVp7z7vDASlgbsz/ms/y06pc89Bx6Pjb93RvDn+XxGvdhmmsN2MDReZcLc?=
 =?us-ascii?Q?3O0BNq2x0o2CVf9TS/DlnW67eky/c6RNS7B9aEktkwdmZSKhNTtatypjrQD6?=
 =?us-ascii?Q?EhdJ4/u1d1i6JTdjFnYHQ1J5R8EM99ZcH4ho0CxG0vkEcih5b66b7H7Uypte?=
 =?us-ascii?Q?8PL/Mj7x2HdIvfMoB5+1TsRp4k8oCmj5CLU3uc32MPjf9l6JVykXG2vOL/7o?=
 =?us-ascii?Q?5azDKCdgzX0v+hnXbI5hjtRiY6Pso9HDyghs6xArc0yUotJZ8htgkQBtN7Js?=
 =?us-ascii?Q?evWsFQt1uhzANnGYTy2N5Zl7Yw8YmfJhwK58lL2LG9ALsoigrwySVZzd27yJ?=
 =?us-ascii?Q?f70KqYGmIxVxP79ohEEtYS4mFXrxaj+MU+G8jPCd6b20jThuP1sfOMKaf5+l?=
 =?us-ascii?Q?CVRj2eN6q+Xw/dAG1P26sRDGvjcS8YmUXVlObvh8PHI3xxxGjhTSOAGdOOyI?=
 =?us-ascii?Q?/W1bpgruEMZ3DbqoZbjNVtHzn+NuIlYeD5oR0/TS+tT9JdiR7YSHMtssf84s?=
 =?us-ascii?Q?rtLzJGw4w6SR/5dOo9AZs/Bv9mKHCcKZDf5721i7SBkf9ErcYfLeBc1wlGR3?=
 =?us-ascii?Q?4AUGWTiKMYuMfPjTiLOyC4htG0ecDLIKZ2pFt4Xmgv8n7E2yBVVj2ZsH1q/r?=
 =?us-ascii?Q?TEXiU3+BVEY6QabhMq4=3D?=
X-OriginatorOrg: cvut.cz
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ade0a1-bc79-4ee4-d1c4-08db1c0c6a88
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB6548.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 17:26:25.7468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f345c406-5268-43b0-b19f-5862fa6833f8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vc/2m7GEtHfjhvsgOUj+pfS99wzh+S4rALdL0EOqm+bujUwMx9B3V4JAPvnB10J0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4281
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

On Fri, Mar 03 2023, Michal Sojka wrote:
>>> On Wed, Mar 01 2023, Oliver Hartkopp wrote:
>>>> I can not see problems or drops when using
>>>>
>>>> ./isotpsend vcan0 -s 123 -d 321 -D 9 -li
>>>>
>>>> as data producer where I added a counter:
>>> 
>>> Really? 
>>
>> Yes ;-)
>
> You're right. I have just forgotten that I added the poll patch to my
> default kernel. Thanks for testing.

It seems I was just lucky in the morning. Now, I can reproduce the
packet loss again even without my patch. And my student Jakub (Cc) too,
but with kernel 5.15.

On Thu, Mar 02 2023, Oliver Hartkopp wrote:
> Hm. Everything fine here with 6.2.0-12944-ge492250d5252.

I tried the exact same commit. When the system running the test is
mostly idle, I have to wait many minutes to loose the packet. But when I
run the test simultaneously with Linux kernel compilation on all CPUs
(make -j$(nproc)), the packet is lost almost immediately.

I'm still testing with:

- receiver: ./isotp-poll-test -s 321 -d 123 -i -a -b -q
- sender:   ./isotp-poll-test -s 123 -d 321 -o -w -b

-Michal
