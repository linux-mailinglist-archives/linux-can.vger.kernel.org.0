Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8818D6A7D87
	for <lists+linux-can@lfdr.de>; Thu,  2 Mar 2023 10:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjCBJVc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Mar 2023 04:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCBJU7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Mar 2023 04:20:59 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2130.outbound.protection.outlook.com [40.107.6.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1961BAF1
        for <linux-can@vger.kernel.org>; Thu,  2 Mar 2023 01:20:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFSU1q2kB22I6HXFJlfcm13wDBsS5KgnOLiGYs5wGZcVdUwBVa2G0bqXu+jb1I3E9NZ1KpuUh9u3224Banodr8LbOb1fppiXUbDBTxoXtWTGx0oH2aEfikG37CRb5FGbJa9PpOgEe0/E5VcVebwUtiUX6uQ8NDM4U5V571UZY0LlahwE8mI5I2qr/VFNsyyFVj5ZJNdjLzqDMOrHp1O2DjSc1Zo4M68tOOZTTsDJ8DDereUiqNZsN2mOTIM/JVqZd488Nq1+V3CVfV4lX9i70iCvpD0UJkg0Yf2sKxAmXlHvUuQC0FdTLpVdRe7Gno8E8oH7zuQGrHoOYwu6eoEfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BzoO+IN0fCXQUkuOeI/LfW1qo6lOozsbT2tLQ6gXXk=;
 b=Z6EO/IdSdHqBfuIrtgX+ZBoLe+HvLUHP7Yrhoic/5QvJHeoI/E5SPt8AwBiNYQ41Zxk9nZsuQfO8WMQKciPHUsyAMdYXF5VeBVMeNfYHRjAjiKgjzUhpI99Fj+YqcCWZh6Nq2pHsVhWGW4HIYntYKjd4S/oYoHc1T7GJQnLnLd9DHnFrXRJO9fjLbrkK6GTfwKPksx0//07FUCS7xwx43VUhWx+gD2DmlXkKOE+lyal0fzqAQfjkQMCrahAO9nTdQZAmO0AIRaJTmyVbDFlxoyUtPl4+WAoKm00BEswl0IW2kmS2EO9nBRsTsEOfP9njx83w19rNjdk2iGABzBtrbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cvut.cz; dmarc=pass action=none header.from=cvut.cz; dkim=pass
 header.d=cvut.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cvut.cz; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BzoO+IN0fCXQUkuOeI/LfW1qo6lOozsbT2tLQ6gXXk=;
 b=FOiW7zqrRJ8mTm4MSC+C8JbP0UH8fpLwxbm6ZGbDRR/UhUbcCXzY5lP+ALRaCxPemMoJNJSTMEU8/Mz0lPDhgFteeHhddQyOcIzuTM7GUPwFp5BD9jRxTO7vWE1epJN1CtYd5kZc7mvcqX8uCFmQ5kD3BxsuqXwMMedPkqWwZNoCrOPyaanCeUMYKVmegHNnosJW5JMlaREO3qyffylIv95fdMBM0kvw5I1vNg+QFPF0L6qinZNrSyi75cGoWEF7+bJn2BUKB7Irc8G69zBLGAT+WMX1yUt/LrJ1B7BTwhZlgZJApGpDDdXlkuTq0a03RiR5EUcrmPvABQvwMy3gmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cvut.cz;
Received: from AM0PR06MB6548.eurprd06.prod.outlook.com (2603:10a6:208:195::14)
 by HE1PR0601MB2603.eurprd06.prod.outlook.com (2603:10a6:3:53::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 09:20:47 +0000
Received: from AM0PR06MB6548.eurprd06.prod.outlook.com
 ([fe80::a3db:1265:91f3:b6fe]) by AM0PR06MB6548.eurprd06.prod.outlook.com
 ([fe80::a3db:1265:91f3:b6fe%4]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 09:20:41 +0000
From:   Michal Sojka <michal.sojka@cvut.cz>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Jakub Jira <jirajak2@fel.cvut.cz>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: please re-send [RFC PATCH] can: isotp: fix poll() to not report
 false positive EPOLLOUT events
In-Reply-To: <08d8e225-0e7a-a75f-f8fa-e4a8ce99d4a4@hartkopp.net>
References: <b53a04a2-ba1f-3858-84c1-d3eb3301ae15@hartkopp.net>
 <878rghtt0p.fsf@steelpick.2x.cz>
 <08d8e225-0e7a-a75f-f8fa-e4a8ce99d4a4@hartkopp.net>
Date:   Thu, 02 Mar 2023 10:20:39 +0100
Message-ID: <87zg8vjyqg.fsf@steelpick.2x.cz>
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0021.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::31) To AM0PR06MB6548.eurprd06.prod.outlook.com
 (2603:10a6:208:195::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR06MB6548:EE_|HE1PR0601MB2603:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c072bd8-3efa-4abf-015c-08db1aff64d9
X-LD-Processed: f345c406-5268-43b0-b19f-5862fa6833f8,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZX5rumqBqZsavH5AsmLVT6gVTz+WOJPYUNdivdBOsp9iYTxo4NrPepsKIs85iSqFQC8Kunnk/S9UjKu2/+ROAs5jIg6RJvlAqpP3taSjkBMldQKrX81o86uN7bqY3HS3EExSWmLrt0jAZt0gXLUyzPJzmyZbRjjDgQEeGLKursCA0Wx5VBnsqH/bzDdjzPk8nQnL8NIq7ajDFx+BcNe1TdRXz6E6uToOOhC70RrVNGQcoWmz3Pe8SFca5mcm84MGPHP7h0sOkI7lrHg9tp5IDI89vHsjy8OTmbH0pTy5Kfc6vWuYSFG7ivjEcUHdopEvY2lEM32c8JzQChxsylw+Jb1+npvgX6k0qbCw15Ubnsh3mZeKiQ/95RnYrA8spbUub9Xgo9Bgm38cU/lv7Lwsvb2hO42ytJQmkm4pFzG0/G4RPO2CEtoCAdkhTHALvy8jBmFmY1TzFKbwsUrsPY3p2jyDaxsSNf1BFyFcjBVetB1r9uSxFvdCwEFkyZinetDs/dueTtjZ2/9SbxmLbOnd5H79mV06GSNCiPuWOClHvp6s+0vHLaeSSE41m4BKXp87g/Tm/G/e9aqED9uQTH57cjkvADElP2+u3W9u09c5NiXtEzGhBLr1+9X1z8heaD5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB6548.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(39850400004)(346002)(396003)(451199018)(41320700001)(478600001)(83380400001)(110136005)(786003)(316002)(4326008)(38100700002)(8676002)(66476007)(6512007)(186003)(6506007)(5660300002)(26005)(9686003)(966005)(6486002)(8936002)(66556008)(66946007)(44832011)(41300700001)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CTelG0kGJu03lxZ6XW+DHucRpan7krjyUG9723Ng9aQILdvWuvWgXjR30Jen?=
 =?us-ascii?Q?AHvC2lySxdkq+Ic8kWOUc28IkvUjFY1LA1d3ccbllAPMNhvBl65+oWFR64MI?=
 =?us-ascii?Q?poKAl5nOxKk20ChyU6fXI3bQ++EWixLZ1bUgvbVfYw+YUeviDVOMmzh+Va7u?=
 =?us-ascii?Q?rCLu4ldTuKryew707EtZTqR4qIhfkkgE/Fb5XDTjp/REMjNamaHrdo8bob9M?=
 =?us-ascii?Q?5oilkMV5Of3lW0OLaj18NJ9DIi5/fnh9Xlpkx6CONQVr26LGheX3QrXFL6+m?=
 =?us-ascii?Q?g1t7a8/dGLhjPPfooqwCf0jKRJ995m+bHB8MhYTOduO5gvtfH4bikOOvF5WF?=
 =?us-ascii?Q?hA/+ADBEB/Oj0YAxWQ2E+E3Ii8LRkMJSellYh0zPXzUJKZ6FusCOyC+PHsAa?=
 =?us-ascii?Q?oA1JvE8pZqDQaMkoDgzA4R/PmKjfS2We7d0weCITNXTAxDFNBDnfPqTphdj5?=
 =?us-ascii?Q?POI+uF+p/ynL6DJYU48vm7ZPjzWlC9VlEaJeiJVJCcZkYtNd9ExOc5g/wkCr?=
 =?us-ascii?Q?tpcZuODIHxYX08sNUKDbyWgfbj4lfyN5Col3B8R4ir9T5l9kiQ+eojxepfdJ?=
 =?us-ascii?Q?HcNpwLZMcwjPi4Xbz6HnQ5HGrt+IcmYgBnXTT9G1be4sLPOMoCs5MkBdloQN?=
 =?us-ascii?Q?qeKOPsTnxc7F2Z5UMMmpZdrEws9IKUsJYU2+3M/WGC594B62MVsJ8/Jdt5AJ?=
 =?us-ascii?Q?WC6C604BGbRaKFS7luovM1pvmVdmXDxn1+caLUc9GURbTWiPUbaDSCyHlDJt?=
 =?us-ascii?Q?rUkSCvwlFzgnkp5PLN98gCZIBAc92LLKZrhjEYujmxv7vfo1Y7NuArW+9xDh?=
 =?us-ascii?Q?g3LcNAwoBv6vxDtPitvmuUFQjPDgFyGmwi/24dChs2JW5WBSeVIX3joHdWUl?=
 =?us-ascii?Q?g/AMJvLqsp5wRgXJ73e6On2ArS7d29pAXTycHstp9jXuE2ZzA39CqxtPldOS?=
 =?us-ascii?Q?n5kUu2zDI+O1Q4uyYdJ8XziBjp0M106IU6kjF2h7HI9hn5PqPPXUQF5SbON2?=
 =?us-ascii?Q?oaU/i638k/BSq+zYVutCvGIlra3UumYuKwPGx8PN28yn8dbL4segpZy3tnbL?=
 =?us-ascii?Q?IJ0+RGjWXMWmBtm0BjuptsDkzGlL5N7NRlCvsRAgoZqCf1a31XegSTxSqTXr?=
 =?us-ascii?Q?+Jl5VCyT1VGWUHeheXfBqhcO3T9VIb/LgAtXzcB8ph9R4fNMlwBsr0GsZpXJ?=
 =?us-ascii?Q?12Ffip9MxYT7wl9yPQxcGMtOgBE1MCf0sgvy7p26e80Y3rk2xq8bP45R8Xa8?=
 =?us-ascii?Q?wAki6+6NdUoysGO0NftAvIp1f6W7o/W4i8Rrhs5hNbYDevjUTG6z7gvMjj5l?=
 =?us-ascii?Q?kqMqHOzyTWPNmbHd8txDK34BbZjS0Z7pU0jshNTCYC6I3GnKg11PgAWkAlcV?=
 =?us-ascii?Q?Shif3gDI2g2fWrQudyLyhZyQcrYKf/1IGGUCmxwNFzaqbpPRWNOiFpVN7oAH?=
 =?us-ascii?Q?vTOnMIOtmpuaA92gV1PjyfM4ypeLF84Crw60p83htING0LlVQ1/Ag0tT1HAM?=
 =?us-ascii?Q?QtX9k03Zu8++ImxMymXDbaJuENFpzYW8ZeKGO2FzFYMiHeMYrMGgwIz82noK?=
 =?us-ascii?Q?1+NHCYEIfc44KMfDXHE=3D?=
X-OriginatorOrg: cvut.cz
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c072bd8-3efa-4abf-015c-08db1aff64d9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB6548.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 09:20:41.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f345c406-5268-43b0-b19f-5862fa6833f8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgpE6uS625nFN22zk+XhUuT3jt130i2rHVpp5gGUGYbQ5W7Bll4YnmMmWbnGxAVf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2603
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

On Wed, Mar 01 2023, Oliver Hartkopp wrote:
> I can not see problems or drops when using
>
> ./isotpsend vcan0 -s 123 -d 321 -D 9 -li
>
> as data producer where I added a counter:

Really? I tried to modify my test program to also support blocking
operation (without poll()) and setting CAN_ISOTP_WAIT_TX_DONE. It's
available at https://github.com/wentasah/isotp-poll-test/blob/fd095b2242c49dc5d3e36faf5ac9f4f47fd002c7/isotp-poll-test.c.

With it, I detect lost message in mainline Linux 6.2, but sometimes, it
takes quite long time (a minute) before it happens.

What happens is well visible with strace. When I run the receiver as (-b
stands for blocking operation without poll()):

    strace ./isotp-poll-test -s 321 -d 123 -i -a -b -q

and then the sender (-w means to use CAN_ISOTP_WAIT_TX_DONE):

    strace ./isotp-poll-test -s 123 -d 321 -o -w -b -q

The output of the receiver is:

    read(3, "Hello122813", 99)              = 11
    read(3, "Hello122814", 99)              = 11
    read(3, "Hello122815", 99)              = 11
    read(3, "Hello122816", 99)              = 11
    read(3, "Hello122817", 99)              = 11
    read(3, "Hello122847", 99)              = 11
    write(2, "isotp-poll-test: ", 17isotp-poll-test: )       = 17
    write(2, "Lost messages. Expected: #122818"..., 50Lost messages. Expected: #122818, received #122847) = 50
    write(2, "\n", 1
    )                       = 1
    exit_group(1)                           = ?

Sender's output looks as follows:

    write(3, "Hello122813", 11)             = 11
    write(3, "Hello122814", 11)             = 11
    write(3, "Hello122815", 11)             = 11
    write(3, "Hello122816", 11)             = 11
    write(3, "Hello122817", 11)             = 11
    write(3, "Hello122818", 11)             = 11
    write(3, "Hello122819", 11)             = 11
    write(3, "Hello122820", 11)             = 11
    ...
    write(3, "Hello123116", 11)             = 11
    write(3, "Hello123117", 11)             = 11
    write(3, "Hello123118", 11)             = 11
    write(3, "Hello123119", 11)             = -1 ECOMM (Communication error on send)
    write(2, "isotp-poll-test: ", 17isotp-poll-test: )       = 17
    write(2, "write(sock, str, strlen(str))", 29write(sock, str, strlen(str))) = 29
    write(2, ": Communication error on send\n", 30: Communication error on send
    ) = 30
    exit_group(1)                           = ?

So my impression is that this does not relate to poll() implementation
changes.

I also tried to update my poll patch to take into account the so->wait
wait queue. But the result is the same as without it. I will send it in
a separate mail.

Best regards,
-Michal
