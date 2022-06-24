Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9D5559E11
	for <lists+linux-can@lfdr.de>; Fri, 24 Jun 2022 18:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiFXQBe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 24 Jun 2022 12:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFXQBa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Jun 2022 12:01:30 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94015252B;
        Fri, 24 Jun 2022 09:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYS/63TPWYX98OXstU6xp83chfrIWSB+K3Me/vSob5cOBUU2Q9k44DBoQSkWg1+hD62Stp7AqWRSJNHvUPqAMdTx9mozD/0xKoiWh8kJzyVKsAo61+Vm6v2VKQdq8ADkSvJV0qJf4rcgiC7YpPSUgvH632/utmvaOSE583Jg32LJQD/wgBh8Zw9ERztmmd2qdkpz9uqvtJkYoMuGfoCJt6hr/I8SKkermFErPKvDt6+lR2Q5ZtMTBXfnNpB8fkkG8Td8ZOGPhvQI9AKN9r4Q4l27JoFn6h+l8YaK9L197MmAnB3dREYHYljhCbHel2ecs2YWX8NPzIuWzwVQoqgjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErlMoCKHFc8+fGZckidIn/Lmu/MRd8JEYirBZre50Q8=;
 b=c6mIMOv0HsUXcQ3q1yXvP5ricHLH7bc18TNLJ9rouVxVOleNxf45k48yWTdrYTlH9pDjk1/N3/9paGUKrH8NrVzZs5IFZ8LamrZIi8q7XtpkAekhuY0E1pUB/rt2gSciCe/ULI8cdQ6+Jx4eKLWNyPpEoyXF5dB2ri3AYaV0ejzS5dkBP7j1YgF5U50kEFJzWlB8pOF/oWgd9aKJverMzrZe2PcY+ru7uOlN32bHFtMzYQ3sPGEUYvYd1fDpQRPIYAe3Uo3lcjaWaa5qFGxYV14Tgn6aF7PJI63/pjrfo8wqj6HlKhmDxDKRncsDUJlJDhkcgMSlsUbqs1AQjooG8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErlMoCKHFc8+fGZckidIn/Lmu/MRd8JEYirBZre50Q8=;
 b=uVMzB8nqC6S19vZn6IPMTNvmPSvlpWKTJK1rQgspRQh5dhkm+8q6GRG6otkOYA7YixY+KvRZwJRhnTLmQk6wqUJg9ati5uO0xvqkxipBWtppge2jNv1iVTBQTDWBJb3xxv9j99kqV+ql/ap5jPyZpD+r0oFRNijD1tmGRIDefAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYCP286MB2733.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:244::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15; Fri, 24 Jun 2022 16:01:24 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a162:2f17:bb41:c95]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a162:2f17:bb41:c95%9]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 16:01:24 +0000
Date:   Sat, 25 Jun 2022 00:01:11 +0800
From:   Hongren Zenithal Zheng <i@zenithal.me>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Message-ID: <YrXfx1rYOzNHnfGB@Sun>
References: <20220609204714.2715188-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <YrSjRvb8rIIayGlg@Sun>
 <143b863d-c86b-6678-44e6-38799391fa36@linuxfoundation.org>
 <YrXNltWSYbplstPx@rowland.harvard.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrXNltWSYbplstPx@rowland.harvard.edu>
X-Operating-System: Linux Sun 5.15.26
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: SJ0PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::16) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f64d819-fbb7-4ac7-8bfa-08da55fac987
X-MS-TrafficTypeDiagnostic: TYCP286MB2733:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqpjCIKUuBDyLBubKYpBaAll6qN1KUAmL3xCSH3NhXFZztdSZ++9BhNgOzkBcjc3P3iPpgPmen4JTxIQIPc+NcAFykI0SWE42ck1LB2FguWoZj8+IrnyXLRhlhD3AF6QR+4nQNpxxjDSMxxU/ZFKW7ooFJoBJ/eJ1gzhct7bnz71/sEqgtblBuMdwje6r0cUVSe4/xFfd/btXK8LBOZwGXbult/aW9bP9Y2TFtetqRcV4YUs+zu30B7qpa2ClZaoqJjNPqGP95y6AJBlCc5cFSDQIqufHi2g4ZNb/Ufy4VcgViarWih6T8EUYCEedzb4DTAJvObL26Aut2friu5bG78l0QP1WtmuEl6Yvj661KnTtOuZ7MBJkXzhIxDIwBitr9bGHHt1EI0LVcronxCauwegIC4eEBTltav7L8zbJtrDOXHfbHkxdSjxQZHJaVNeeMgCvoJfvRjubfmHajKOYmuG6EWNDZtQqrXz729pYDwyx6V8XRHdgg7GP/LyVaEJUCJIBxbPiLIwE3vueFF+OM6IkN3Upgfla2TFvClNpfdmc1bQxkixn54JIZOZDqQsRubTDI66dTMAXBO8aycsdsegYaa4WM8yjxPj2NHuhcck4gVlbvJF6oKTzWqJ/yCw4hhhtwyyeQ87Id/UBXq1JyehvJaFkTy4eBtzIjB5gVT2TlGyxMQIES8NZYvknlNiEJf94edDEL0IUzXmsgvxOC2NKWTjsNtSc3XYSUxdWRuNB7hwyuqzceCUpI68GzOileRdiAs3zetawDDvkU6zTrwffN7zeJRNywElUT6pcR8MwbTCufr/8RUT8RWJlljt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(396003)(366004)(39830400003)(136003)(186003)(2906002)(6916009)(54906003)(316002)(41300700001)(786003)(478600001)(41320700001)(6666004)(38100700002)(6486002)(8936002)(38350700002)(5660300002)(9686003)(7416002)(6506007)(66946007)(6512007)(26005)(52116002)(86362001)(33716001)(66476007)(4326008)(83380400001)(8676002)(66556008)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6aIa/Tlah9PunQP6btaBmJ6mBI7OnzWJUN+1bH0O2QJowecMHeLkrqZH9ibn?=
 =?us-ascii?Q?G/4DgBVSmAMjA6xBLZHZDiam28PZP5uKmgKKgIW6BUmt2r/pXSsT6zEmw/wI?=
 =?us-ascii?Q?9QptVDMOCDJu/oFRkjfKQeMmMI1f+n9EB/BKxjQ6MdB7o+M/qrCDP/zm9RUI?=
 =?us-ascii?Q?i8QrIbzkdXBv1zYTp0x7wU7nKvGR3tc4DwhvviDr4HZO8wrVsqluQtAY9owT?=
 =?us-ascii?Q?qkPra+FNMNlT8YREidiXmRNqMgVbKR00lteCH8HU5wmb3n2Gya1qA+AXNxmM?=
 =?us-ascii?Q?Ob5f5eCdtkUPlhimLLL/b+CaY639fgvjHVPZBuGwDcrYyETNX5yAdSrPVYAB?=
 =?us-ascii?Q?rncaIstm3bk/ofm6Sv9gfWnd0KmkDwHpD1A0pOL6BPuyjM3coRKILlKm9/p/?=
 =?us-ascii?Q?FCa30+Gp6eKKKR8EeGJTqYKkAHN5q2rrbG5A6uzQtuGU/0E6njovDShpOgrk?=
 =?us-ascii?Q?/U2lGaQGLEfvOMhEokDobQBIicc92zJoNWOYydLCMnO+sUF1MOjEgjzuXyBN?=
 =?us-ascii?Q?HW/KPtFtTCGS5ecp8jMeXJAhISPE16KISi6pLmHmNIwxYlMewfapV4yLHb42?=
 =?us-ascii?Q?Eco7oaoHQRH891U2Sc+bb+6tQQDtWd+jRHT8uiFdamu5B8tz4B5QkMHcUJbp?=
 =?us-ascii?Q?QPhWxYCSPQxw3kmLF2VaIvjFpzobACog/LJHdFUkCorRwLx1n8qVjsA9SwX6?=
 =?us-ascii?Q?b918dryDHzb9A/cOhsA9ZnWySCGcRFQ5qyoqSvlPKy42qmQxbkVoaeoeXRSP?=
 =?us-ascii?Q?S+jVq65jtjhi6fVE+18CrJdxrUgUpQ8Cj65Zj27zkqYg1M2vDEAEWAPVIE6K?=
 =?us-ascii?Q?u3l+I+JJqxV2RlGJlwe+l1+igkt4hJZzWvoyJTJICyQ4yJDJpC3pXHyUduRy?=
 =?us-ascii?Q?zm6TEkK/tsGyLzwnFRY3TqjvEGO9zLuZIz77A5RSUApluEd2F/XxaGcAzyIS?=
 =?us-ascii?Q?3NCIQ0F74PLxdC1UlUaAG9Ev2Zidj5kkC2oau1ZIhzT/xYWPWYXPl67R/B9n?=
 =?us-ascii?Q?K3fnUifBx5CE4UhedbEWgQy6woygOczZVaW7TZesARqTVmu2ECgAbh+q6kTC?=
 =?us-ascii?Q?s7YlTi8wyHGiSc/oggS5wxY8BgiEVugbetwnZYPPZK1Kzv+OQ1QnFPL+Ltwy?=
 =?us-ascii?Q?6jFX5Fe+E8HDFX54zwdAzOEpHVElVzvjx82Tn3miPNWhWmt3FZal1gisRvjZ?=
 =?us-ascii?Q?8L3fA5GtLNbyFUKWaNxXERxS90+iTFkEjcSwIP9aUg4AZ9/31BLWclvuWgCi?=
 =?us-ascii?Q?6bgZ3Fau+WES7dZXdVGCAJXbVwCZcXyFPVa3w17R6ApYgjRcx6YWxCs2IHKL?=
 =?us-ascii?Q?2NWDHRBEqORrpK9wazlM3uvdYVkPcuA2dfk6qD6INWAT29Nctev63RWnLpup?=
 =?us-ascii?Q?4OkvNOJj1cmQ4gJ68q2k07W5oGWXpY74xvEmfufkEaGx/m9MR7qwm3SaMl2C?=
 =?us-ascii?Q?xFeYpWulCi6ZKQ64FzkJ6x6E8z0zbeoB6f5o+Yu31ExMEO3ISXTUxC22/uVW?=
 =?us-ascii?Q?c4QAwGNkrkO0QHvldVRyv8N75m4aTSiqxhjStZ55j4QUyMIw3cQKioqBJQRz?=
 =?us-ascii?Q?/TWA2xttrn7X3EGQy64=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f64d819-fbb7-4ac7-8bfa-08da55fac987
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 16:01:23.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEcmpra68uHL6MGfZlwbAhMOVrJ1kBd7sapYh0AGR1qoXjzoZGCM0XCiDId92OSb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Jun 24, 2022 at 10:43:34AM -0400, Alan Stern wrote:
> > 
> > > One way to solve this issue for usbip
> > > is to add some boilerplate transform
> > > from URB_* to USBIP_FLAGS_*
> > > as it is de facto uapi now.
> > 
> > It doesn't sound like a there is a compelling reason other than
> > "it would be nice to keep the flag values in numerical order".
> > 
> > I would not recommend this option. I am not seeing any value to adding
> > change URB_* to USBIP_FLAGS_* layer without some serious techinical
> > concerns.

The transfer_flag in usbip is de facto uapi,
That's why I'm proposing the USBIP_FLAGS_* way and
further more I think usbip could move some flags/structs
in usbip_common.h to include/uapi/linux/usb/usbip.h,
instead of the userspace copying them into their own
header.

I will start a new thread if Shuah think that is acceptable.

If this patch is to be landed, I think it should be
landed along with the usbip change so there would be no
userspace change;

Even without this patch, making usbip flags/structs uapi alone
is still worth doing.

> > 
> > > 
> > > Another way is to use 0x0400 for FREE_COHERENT.
> > > usbip will not take care of this bit as
> > > it would be masked.
> > > 
> > 
> > I would go with this option adding a clear comment with link to this
> > discussion.
> > 
> > > Cc Shuah Khan here since she is the maintainer
> > > on usbip.
> > > 
> > 
> > Thank you adding me to the discussion.
> 
> I can see this causing more problems in the future.  There's no hint in 
> include/linux/usb.h that any of the values it defines are part of a user 
> API.  If they are, they should be moved to include/uapi/linux/usb/.

I agree with this argument.

> 
> In general, if a user program depends on kernel details that are not 
> designed to be part of a user API, you should expect that the program 
> will sometimes break from one kernel version to another.
> 
> Yes, I know Linus insists that kernel changes should not cause 
> regressions in userspace, but the line has to be drawn somewhere.  
> Otherwise the kernel could never change at all.
> 
> Alan Stern
