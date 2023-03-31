Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7E86D1DE0
	for <lists+linux-can@lfdr.de>; Fri, 31 Mar 2023 12:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjCaKV4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 31 Mar 2023 06:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjCaKVI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 31 Mar 2023 06:21:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2103.outbound.protection.outlook.com [40.107.21.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD9E1C1C3
        for <linux-can@vger.kernel.org>; Fri, 31 Mar 2023 03:17:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dd4Ieky5tmPcEjV1rL5ji6XlQ5RTSbaAU0jze2mB45Imdbiq+YShhtwGkFcy3Gt/Qk13pe8NfZ3OFYzCa1XD8FZbXLal9nwPKtKdbku9YLntkfFNfvKqwMgN3H5CeCfOlAvog/iNKnJnWFCxrwBqQqSsOXBFRBpB9rSgAmB8zFRKPdRalER2KAmEWZL7mnPQryQ+WkGaMAcXLGzjjVVXvlGqJoB9qGhlFTrLo8YvcUISGYTBNNBDIzJLnqgq0rsgM9FdL4ilBUt+Fnpt8pfB84rfT8eMU68SCMFvj4TjlaFmNWHL0KIymenLY4r2G+QDZWPqXxAHkD6+r0uLx/eHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGFskeCggoqs353JeHSWMISwDyLXX4q+1ancJkjE6R8=;
 b=Nw508hULc20+dar6tH9qCkqZRwp6alQosgsA7Whmerw1IiiqeAovbeU11wTbq/FHZOPSj25DhRo9Kz28FgHrt962hCNnlDQaEGzw6M2fVXxEcDGkpPKQyGorA7p6LN594NFsglkMy4ABVZztnVSNw576xsO7jLbndm4CEEsmtpolo9SxKujJGrD5RxFHCkGhYnsV9+AfrIQHgIlYo+aT1vwYI/wQ5OMKaMKMdi7xtrjdZOb625m+J9fRJVwr0uJBY9h9ijFLJjMMXW5ow9pqPRYq1IlNMGkcRX7Jys2o/Ilfd1r85HZ/AWrpVfzl6k2OQq9LJ0JaZfpA5hud1zjSKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cvut.cz; dmarc=pass action=none header.from=cvut.cz; dkim=pass
 header.d=cvut.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cvut.cz; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGFskeCggoqs353JeHSWMISwDyLXX4q+1ancJkjE6R8=;
 b=MNpEzQnnPQ7E2iZNe2cHYoHnx44iu2eDxA9KaTRC3bM/tHP1tQBx0ggJuZdnne0xlGO/LH2Gc9p4Xzq3m+2KO40RINzfnizRHNlCdHB2k36aBo2iTxArLhDjWJCbx7eReuVJefgW8GIn9TmOiBj3+4j3JA3mmAjmLNn7hzErkwbtzUKWchOraF318QN3OdejKB4RpEamRLo5RTQeLzH3nKPi2n2aZt2OpoCwZMc90JS7sOw14zpOciL2lm6d/OXPP3IXf0DcDR/8C8f0ENkfIW9pW53omThEnJ40kVpcwMugc3HteDfUUEt+hmx/EwOVFYjO8wBFzg1UYEAUxOHFQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cvut.cz;
Received: from AM6PR0602MB3749.eurprd06.prod.outlook.com
 (2603:10a6:209:1e::32) by VI1PR06MB3038.eurprd06.prod.outlook.com
 (2603:10a6:802:b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 10:17:29 +0000
Received: from AM6PR0602MB3749.eurprd06.prod.outlook.com
 ([fe80::73e3:8c3b:7d69:32dd]) by AM6PR0602MB3749.eurprd06.prod.outlook.com
 ([fe80::73e3:8c3b:7d69:32dd%3]) with mapi id 15.20.6222.033; Fri, 31 Mar 2023
 10:17:24 +0000
From:   Michal Sojka <michal.sojka@cvut.cz>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Jakub Jira <jirajak2@fel.cvut.cz>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: [RFC PATCH v2] can: isotp: fix poll() to not report false
 EPOLLOUT events
In-Reply-To: <4d48e780-5655-f251-05ee-623cbce0d20e@hartkopp.net>
References: <87zg8vjyqg.fsf@steelpick.2x.cz>
 <20230302092812.320643-1-michal.sojka@cvut.cz>
 <4d48e780-5655-f251-05ee-623cbce0d20e@hartkopp.net>
Date:   Fri, 31 Mar 2023 12:17:22 +0200
Message-ID: <87edp5b4y5.fsf@steelpick.2x.cz>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0031.eurprd02.prod.outlook.com
 (2603:10a6:803:14::44) To AM6PR0602MB3749.eurprd06.prod.outlook.com
 (2603:10a6:209:1e::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR0602MB3749:EE_|VI1PR06MB3038:EE_
X-MS-Office365-Filtering-Correlation-Id: d0178ea6-27a8-40e3-63d9-08db31d11efd
X-LD-Processed: f345c406-5268-43b0-b19f-5862fa6833f8,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USyhxYMlsUW0kOyM6ZKdt9rRifQMCreFxUmaN5Y9EgGrqMLn1EGFwwwuCIl4kpT47RjIO+SkIiBAmucEdCpZ1Gek34YBOXOgMABz3fBK6wWXtNwHCgEPjBhQSPvmtXo7TfinOgLQB3v91WEISlebt3zIKBC6KKjuLVARRuxYgC7qry1eevdzDXP8Z2Sjbur0fhUAzqgzDPtHdvTzp1hUvKoisOVzfifT2ViHtpahU/9rUbkg8DnTr0BDLzUqOakJ8At7mCLfXHuLvTscxVNyd0bUwNUdLLLrg938SJ69I6Mfk0BXV9WAcbZLxYOJ5ALmt+KZ3RGYGkUXNb/hg5CDnNhVp9RMB+P0Qrxfjmeqa8zEykB4kAQSJUFN8zAEofVMdpzV/ArhLZ/cXpGFgzO0H5D68t76ljJPeU/cVHTrdpw3rQZRI5ZAJi4E5Hi79qqzPTHJeKRvERdOJFVpnwjLy+YkqtvOqwbGPA6uiz1vQ98H4MXx74pEGsPHFG2zrRqFHUojgXKnqlEzeDI6Wuj9pgda420wocyiJeuemiEUEMx0CtTawcF2TyvsFTj4d3Ua
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0602MB3749.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39850400004)(366004)(396003)(376002)(451199021)(83380400001)(41320700001)(110136005)(26005)(316002)(786003)(66556008)(66476007)(66946007)(8676002)(38100700002)(41300700001)(6512007)(86362001)(4326008)(6486002)(478600001)(9686003)(6506007)(44832011)(4744005)(8936002)(5660300002)(2906002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bm2l5WI4nKUM6JBHxYaut+kbqZC2lRAbIJBver92EAv+fKAKGC23M+C6dRye?=
 =?us-ascii?Q?VyKwh6hzkfRgv17aPWVBsdrjJXAl4lLtOMI1jSDozZLk/C4fKQzwXiJOaQLZ?=
 =?us-ascii?Q?INHm4mDaNTD5RUbSbqQx7u/2FOg64+DvVfaxSoSlvEduX1Ds/xZzxT81XrKe?=
 =?us-ascii?Q?0XI1xAcw7jwtqa/RdR7IUlmSSxyBMdtv2FOxF/eHMoinIRFeqRSvfqyQbZne?=
 =?us-ascii?Q?7A0ynDCxJ8AlG4Lj191O3J+AMXoUT/6/zjfmZDCWD1fLV8LBLPFmFxO3Roxg?=
 =?us-ascii?Q?+dwSz6rfV8NR/VxqI//nD1Ao5s7M5V+X8JGeyOwcBBZyuN9f391SKtIY4aaN?=
 =?us-ascii?Q?08/ct6bDVQPdssr+k/9hyJKsFw1m6poU1Owfxd0XLpam75z2TBHVZBF3mZ03?=
 =?us-ascii?Q?56xwTEKu5DoVm83In13HT5KyatWQxwwwDwSDw34l7BO1qe1D2Bal7JY4BbWr?=
 =?us-ascii?Q?mcIvs/QHLKx8fk/feJkoW7HLKR/yeVdVOWR1nOoEm7UYDtP/L1yoHsWruNzo?=
 =?us-ascii?Q?rmFIDWrlYIO0IzC4ntPXZp79wVQ8aaj/QPi8inmWKZd1yEXE8SupNlLh8CVx?=
 =?us-ascii?Q?gcOR6MfYt2y/NhkIbcNy3zoXhOiUbRjtNV+pY7zhnd5AOHa/Ubbyi/D7FyHn?=
 =?us-ascii?Q?BJ/NsxQnrelf0rDYnjZsj8yJdpMfqYp4A5/WqxOnIuMJq2Y9VsXslLzjSEBW?=
 =?us-ascii?Q?hBFNpHc+g6pMotF+aA0wd3otlbOwAdN8f1otvOT5loP2UgVxctoEBir8ixo8?=
 =?us-ascii?Q?n/HXRJQBlbxqVlusvPyv151BAr8yskcvBR8lN4mjzgq8FjLQh2YC3QyzsGmX?=
 =?us-ascii?Q?wA1tF5d5f7v87feh6bc47Csk5/4MNJgh6uya2nWGfKWPw2cGnMGWm9UCrTC8?=
 =?us-ascii?Q?tA8PUZKOU4goH51HnTSlzmoHuJqV+n73h/nWGxGJwlNfNurJnJxCok5DDmyJ?=
 =?us-ascii?Q?cWmn6w/Bg1fqk75eUYAV/yyPUb5bAXBtA1wDJSGdZHonWq6PTsXxlGuPQjE1?=
 =?us-ascii?Q?ltW1pjRydTwhzfnwlXiah80qxrbeHwU0m+bxfDNrAHrMvhyTZvRXmO2dSvoh?=
 =?us-ascii?Q?DcwYLRYeHUjfKD9ouekvB/FBuVCQMTUtdspkjRMKhj6zbgcEzWCttAH0FVL4?=
 =?us-ascii?Q?ALiBRPW8nY0/uWdHeoMWVo2ZByfsgQyqEngDlitnE1HcjzOyoJNcrB4aXw0T?=
 =?us-ascii?Q?JUn4tZzFzmcwvSm45hqlxm1WcTEmzUmDu/Lquhh8EqYEWKTXLe83HQJy01gC?=
 =?us-ascii?Q?CUBfO3dflIklyxziHl1WETuEFqBzop4+QK1uNghDb1n1TwBvX5ZB4Nn7b+XM?=
 =?us-ascii?Q?FmwqCTYJocsFRCGjAyEnaqMpGYTO8yrWTx6eu/yiUbwgiTS9n+CPIsJ+V3t/?=
 =?us-ascii?Q?tdEwHEKW8Tkn/DE8DK5es+7mSAgqVz2Q8zaK6FTSDD/ikPxXYZZpwW8D7j/R?=
 =?us-ascii?Q?K0YFSRBxTkSt5GYMbb/khFna9xBrSGOfl3xuak/UP8aeJ6gJdEbFqQKsGCY6?=
 =?us-ascii?Q?GNa9payeuDyeh0TI5TeYNLWd3ccYmc0ZyVaW7t9Jj+RJ6Ed3Dr54jN9BZp3L?=
 =?us-ascii?Q?B8MRDQ7vzefgc/qztSw=3D?=
X-OriginatorOrg: cvut.cz
X-MS-Exchange-CrossTenant-Network-Message-Id: d0178ea6-27a8-40e3-63d9-08db31d11efd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0602MB3749.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 10:17:24.3163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f345c406-5268-43b0-b19f-5862fa6833f8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yymXM1W/CkH3ARC5VXYKSDlBX4P7lRXXLMvoZJG26dLUj2BDYpP0aA2sjo0q0h0Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB3038
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Mar 30 2023, Oliver Hartkopp wrote:
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>
> @Michal: Would you like to rework the commit message or is it just ok to 
> cut the message after
>
> "This can be tested with a program available at ..."
>
> ?

Will do. I'll send v3 in a while.

-Michal
