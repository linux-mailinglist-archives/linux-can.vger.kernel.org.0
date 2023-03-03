Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5FA6A917D
	for <lists+linux-can@lfdr.de>; Fri,  3 Mar 2023 08:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCCHNW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 3 Mar 2023 02:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCCHNW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Mar 2023 02:13:22 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2135.outbound.protection.outlook.com [40.107.7.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5316CC662
        for <linux-can@vger.kernel.org>; Thu,  2 Mar 2023 23:13:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XknLMeANdeg8pZSm7P5zEAYSLKVFSy4/SVW3TLtkCKvoH9Ax1Iart8bn/wv2WnAf099g7jWXeFOMF+xUP3a8t8hOBIfn9IIJGXSeODkHqLUtSWi31gbS8L9uR5uQkVrNMw+L0pBWQLg1+bilpcukaVapTEqQ113W1Pgzva8w/dvtAeU8KRCRhyAZW9zH20K5Sz3KnER0tY435hibXWbNCQOzTZGt9dQlwUh+s3+QlBVMYTaGRXzZg8ESggAxoEWvqTFDyszMcB7If6Aec6CMROaTMlBhWRLzwtP0eH3btUv5kOamJRFnTgzade1OfvUtr9DIkj9D51O9yiq+5ZZOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqX35S0mIyl7kRPrsmIZTRKsxuBitnRNlheEzwobRQc=;
 b=ETcMIhEzNEjaJzA+zj2pK8HEOx4bldbKFL5FxTU0tMcJ540HyabqDmm9uJ4RMPTG2o+nT/81ax+CC2ToLnUtpqrGYpwipejjHa0VBV7ZYRNv+EQDPMiOea0NoDOVZDwgMYvsXI1j9o3rchp2XZegWmXizlqiukNXk2ZJBylBEgp0+WUGA599mmCBdyL3GSyYuawn7pn79zKqEtXpE4cFZqTiHOSKvk5xBW/NuN/uOBdPbXhDMmd/1AkWfBIYCMguOvvq+rwnPyXQdT/dYKD+KeymDRsUdxQWHvtoYHdKNbVys22bbgQvvtAt4IN7xiVlLpM37MBiPe4tRN6LbWLdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cvut.cz; dmarc=pass action=none header.from=cvut.cz; dkim=pass
 header.d=cvut.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cvut.cz; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqX35S0mIyl7kRPrsmIZTRKsxuBitnRNlheEzwobRQc=;
 b=eyylNV9ABH0YGUk7ZX21DkEdhpXTlIEjTEbBuMbw616ksvgn08odEqv7v0aO52ecH+w1s3R3nTW5RHfJ+PUE1uB3cJdtG6/+OhM9uDi4MXWmvrVfSfx7iwUvlCXYOmWdWc7Bg3rogAtFlmzNKIsY3ewO4FhzorlwXenJp4TVxjK7SXzaYq77BDfMQYZEzgB0FYukyQtQc1k9U6SloUo2HeBG4xMAoYvIyYV35uYKAP34xvdMEE4CvKUSSyA0rDjRoBu4Jjxwls/aliHdnKuukKrJhRXz2ToJHdBYl2gF7MtsTTaKJLupxK96aF+6JemnSJ++k5AHxFeWatrEhmRnIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cvut.cz;
Received: from AM0PR06MB6548.eurprd06.prod.outlook.com (2603:10a6:208:195::14)
 by VI1PR06MB5278.eurprd06.prod.outlook.com (2603:10a6:803:ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 07:13:15 +0000
Received: from AM0PR06MB6548.eurprd06.prod.outlook.com
 ([fe80::a3db:1265:91f3:b6fe]) by AM0PR06MB6548.eurprd06.prod.outlook.com
 ([fe80::a3db:1265:91f3:b6fe%3]) with mapi id 15.20.6156.021; Fri, 3 Mar 2023
 07:13:10 +0000
From:   Michal Sojka <michal.sojka@cvut.cz>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Jakub Jira <jirajak2@fel.cvut.cz>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: please re-send [RFC PATCH] can: isotp: fix poll() to not report
 false positive EPOLLOUT events
In-Reply-To: <40f9aad6-81be-e442-2668-cb349fe7313f@hartkopp.net>
References: <b53a04a2-ba1f-3858-84c1-d3eb3301ae15@hartkopp.net>
 <878rghtt0p.fsf@steelpick.2x.cz>
 <08d8e225-0e7a-a75f-f8fa-e4a8ce99d4a4@hartkopp.net>
 <87zg8vjyqg.fsf@steelpick.2x.cz>
 <40f9aad6-81be-e442-2668-cb349fe7313f@hartkopp.net>
Date:   Fri, 03 Mar 2023 08:13:07 +0100
Message-ID: <87v8jiux30.fsf@steelpick.2x.cz>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0601CA0026.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::36) To AM0PR06MB6548.eurprd06.prod.outlook.com
 (2603:10a6:208:195::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR06MB6548:EE_|VI1PR06MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: a8344e20-5e14-4631-4687-08db1bb6be98
X-LD-Processed: f345c406-5268-43b0-b19f-5862fa6833f8,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNo5Faj+3p+uN9nqdtfxP0bKxjl9U69b1PQABgefh3kxuaDgmNPlxGflFStj+QhYIpmbbrbtJBBY/8Q5/i0gNs6OqDDH+lZ4a54J/7ftqJfV/HRbDIj4d1PB2BXl7HNuIgoud0c5y04aU4zA6XPWD3D+s91Wb1k4+sb1GrzMtYnsOQqADY7ngtW+apbQJbQy8ElLxo1SJ6TxKSTs95yo1DXTVU6NMLsyfY1kquH2VPkL6UfsawEIdnK/mWqZW9yGqr0fQ9ZVqu9ERJXf7flKNwicYE/JMJ00wIVB8Igl6FqW4+MMn6U54u80w1rqJ30GawwkyltU9xaIsIB+Z5hYdwtCSx/28jmYfVUGcN/N6m7AAN1Mo54jyj9O4+HzhbjYIq5obpGB5c/uKjjmGDlMFY8GALg9kNnOPeCZ4xzYhjv4+FeRE7kXrVDQANJg8+MeGeFFai0vE0IezqkaJAb69Jg+pJwpiBNzBd/ausUGR7SriRW3ICR4OEdtAVBXxJw3mO3DzaSISRg9OCCT7w1/QZDRMQcfh5WTlaSxy4jKSHO6G5DS7AUNwpaSr8I2pyvYSbVRi4g/K3hAi4oJsiLVs6D0vdu/kNe2iku1peV4oYvZ+/Wlu37VEchLc0gVzdLuWbOn0PzMGniqxwv22OxGng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB6548.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(136003)(376002)(396003)(366004)(346002)(451199018)(786003)(316002)(2906002)(4744005)(5660300002)(86362001)(8936002)(44832011)(6506007)(41300700001)(6512007)(186003)(66476007)(66946007)(8676002)(4326008)(53546011)(9686003)(38100700002)(110136005)(41320700001)(26005)(66556008)(83380400001)(6666004)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LWMdWu10Atf5l+DGnL38+Obb5r1kuKtUeiVbx7q9FK3Rckql5nfsv3wutOHp?=
 =?us-ascii?Q?RHF6SZRDSuE2MJbFfwwrCiRlye1GXTnn6Z/74iUA+3Ivr+bs7+ABmvepxzp1?=
 =?us-ascii?Q?bAOvHhgQ9Di5FxnBnIbT2y+WQB6W061ktVxn4n0GQHrjlmpQfweQ+giXsbRu?=
 =?us-ascii?Q?VPiA4lghPlw5BnxH3kbekPmrvY/ugdgpnT9hxSTR3CRM8E1EGIEklYf/dNYJ?=
 =?us-ascii?Q?723wcVIKrazpa0UyMsiKzmzGW6EpGEB5QXLDwiUGm2ODsjXhSpvxcKVNBQ8J?=
 =?us-ascii?Q?ZClTyTVo+S5mEoGbNAHUu60zke03c6LRio5cLwbR8cCRL1+rRSrVAyFsNIKW?=
 =?us-ascii?Q?vMXKgkyWnMJmPkCnbkdTXysKMpC7YE6ElIIoQQc771P09HzOR5Yy61lRLkvT?=
 =?us-ascii?Q?gJLM3IHyMtYWYMlG0eUd65fj/J9LOTzJSskDn0OLknmboBC1B7O/0yna0MeW?=
 =?us-ascii?Q?0WOO4QkdSayQWipL4UKMbC8S5THMGvitopNbVcSOLoVG6dOsM4oj0G2Q0PxI?=
 =?us-ascii?Q?O3mHF28q1Bv+IcDQ1omy3UL029QjgzoJUo/xbdF+1FcMjPjooGsgzNdlFwBy?=
 =?us-ascii?Q?vIsqsLSbv70XutaqLmQAxySolfk0fiqvWVsecQq8PH8e1iOFdGsrlKV7DsUJ?=
 =?us-ascii?Q?8h1/z8t1wUkmpLSPozDyUXa+ytdzNlJ99DX/Iqk30lUUMmtmj5u1Bo0Em2xX?=
 =?us-ascii?Q?fZ3Vesvpg7uY4LoaPubPJxwfVSeGfNPOYZVifz34M5l30GrvfBXRAHFe07jN?=
 =?us-ascii?Q?LKrXGqPclYBCvIznZ3uNuHtqVhrM4CHjwo1Q3Qg+GoONMn/8pL9WhPwG1wWu?=
 =?us-ascii?Q?jkGIHqnEkwE3qp8VMTFEgVM93JPsooxrTyn1a3k3BR42I5LpStXZDIC3tXVr?=
 =?us-ascii?Q?8VTRQeJhP6Vy0ocgL6fHDVUxTjDgwg/UeYFoYKFtC86IRf+F9C+KJzMhorZz?=
 =?us-ascii?Q?Hb/nVj4+e2lkbii4z7iTobbvIvXWvRZNBgxcVSWNwx3EYeHo5NyahGsNZMkB?=
 =?us-ascii?Q?ZCUBYD3CWGnxJMzVpO8lZtNsmqEYD85kRprMUT5X9Dz54oWpuWTzHYuS7Y/X?=
 =?us-ascii?Q?jNJriazR+1EDGPUaiGZceWar08sGRlQfOv03uslq3rSpOZn9i7vz2zbbWTzr?=
 =?us-ascii?Q?Ky6dgKdG3V4RRPKn0ZjYD4NjiVZJMJrKzQ465Qv1etorbKEd/oQ9HixQP+xt?=
 =?us-ascii?Q?IJZ6a9iq198jOQnIOSne6b9hoduveZ9VoOeWK6aHkhzKaNzFkXdPWqdCyYzq?=
 =?us-ascii?Q?cc43N8CFs9Fa3oXFyotlk73Dw5vulsDSpGZ+0jWn/eZPJ3+msvPDLGgTipJE?=
 =?us-ascii?Q?chBiXWm9HHmY0KczLwl68P1Sd7EOWGISYXNlw0Q9dYwaGIGkqi0cQxYI1DZh?=
 =?us-ascii?Q?AXYDpThMu/n5Zqw9v2D9tz7ooD0FBqoSWp98rcucvrfikizRxaB6hYifgEQp?=
 =?us-ascii?Q?kRdzFXmQNQXqazz/TOM3e6gXceEzsmZ6CI65xgUrJh8u6qYe0+ywPgieZ2lf?=
 =?us-ascii?Q?lBVLOVkn9DLsbqc/ts/GnGNG09ilyNjd5kAJc/yYnTCuCqqi35jY/YFnJcD0?=
 =?us-ascii?Q?56n91gdZW5/pRxyDZqg=3D?=
X-OriginatorOrg: cvut.cz
X-MS-Exchange-CrossTenant-Network-Message-Id: a8344e20-5e14-4631-4687-08db1bb6be98
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB6548.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 07:13:10.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f345c406-5268-43b0-b19f-5862fa6833f8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78ZhROsn2ARNllDdfQvsnXw7wkDGXk9WSPrBvJcagf/uIt+Hi8U58U2rwpboZtYJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB5278
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Mar 02 2023, Oliver Hartkopp wrote:
> Hi Michal,
>
> On 02.03.23 10:20, Michal Sojka wrote:
>
>> On Wed, Mar 01 2023, Oliver Hartkopp wrote:
>>> I can not see problems or drops when using
>>>
>>> ./isotpsend vcan0 -s 123 -d 321 -D 9 -li
>>>
>>> as data producer where I added a counter:
>> 
>> Really? 
>
> Yes ;-)

You're right. I have just forgotten that I added the poll patch to my
default kernel. Thanks for testing.

I'll continue investigating it. It's not clear to me how can poll
implementation influence behaviour of blocking I/O.

Best regards,
-Michal
