Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AE6558789
	for <lists+linux-can@lfdr.de>; Thu, 23 Jun 2022 20:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiFWS3h (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 Jun 2022 14:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiFWS3O (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 Jun 2022 14:29:14 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D90EC8118;
        Thu, 23 Jun 2022 10:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMw2/z1d/x0EUhfmKFBwTvSHszofktZez3mL7e+JkJOdrzUHgx7JxpesP6e2wiRvNRvAeGR5A3eDxAWbo7dE7ub8rpowKltT/kcM8OHn95meXsCCpaEQIKvfmIMBztBUR4HvmYZNEgfXCkAb8DYwn0Zkdv63XHWsedbJLnlqwCqOlfX/GlDtgIT7jQ49QJ9d3dZ5QfuvrayhOifFrK7G9m2TUaqasBMl8spR8Ch8G+9VHqXZLgylhOHtVA3xKmEjD0QXq4a1BQ3y3YkJqJCNYzAYjLF481BscezN80mItDr5djS7oH3Y77oSxbr+NfbwGSCWwQFfsW5xUU57YuaBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BAODYKhnkgY/doJP2ItYPEFpUCDCCP5yXmVhqJI/AI=;
 b=YeG3Q8uari/oW+pkxaeOGNfa5Uxf8OYQOZ5R8wO79YA8LdvVezRK4tOUqIy3dcG8hOcEdTxs6ng6aCXK9doZGwEIEbMasyNu0kunuo4USci1er2l799FcGpkd6kwlCAKEqUni3jC3riqZ6W49sJZky018vwvh6/7V/TdLMnTtUCF4gqyur2LitemXrafVRHntOppII/+kKFZvHITn4uPKdY8lHqrQNHHaF4vcg7YHmOG5S3IwvHR/jBNnuaVpk0MZHEl/rZvjvkfQoVwTDCe7IhEuvMEHCRqR3LVSOr2qeRgD2n+gqCWKrszKQBwznIxexsBcxLg/6VNEq7kgJqtVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BAODYKhnkgY/doJP2ItYPEFpUCDCCP5yXmVhqJI/AI=;
 b=PSV5oCkJIp/nBypBTmBKIYrzRrHFhtuc9SpP9m07UZIyAhpOCfROUXz3bmpobvJyqIN7v4lr0Vn7g7CSH+pkrFl81XgGYN/NhUrjiBY9SLPW1NArAzxE1eewB+T4cUOHulQTgM1yKCjQ5F++KHQFAHPpzIdszN1+iHuYmErzHY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYCP286MB0861.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:7c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15; Thu, 23 Jun 2022 17:30:54 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a162:2f17:bb41:c95]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a162:2f17:bb41:c95%9]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 17:30:54 +0000
Date:   Fri, 24 Jun 2022 01:30:46 +0800
From:   Hongren Zenithal Zheng <i@zenithal.me>
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Message-ID: <YrSjRvb8rIIayGlg@Sun>
References: <20220609204714.2715188-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610213335.3077375-2-rhett.aultman@samsara.com>
X-Operating-System: Linux Sun 5.15.26
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f209cd50-3c75-4c65-bd97-08da553e1fcc
X-MS-TrafficTypeDiagnostic: TYCP286MB0861:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0r0tLhutEWW3Dg7xO9dwj6q5UGUgeVzH5mkgBTJhyik+lcOWVW671oesP8itBRtzXFYwkHeMBNlfk64OBq0YuoQ9SOZDPwyBxGBQPUa2y/gQDuOvi3hbfxjrOY5R440dyj/rkSL/Kp0y4M4hnHr5l835dEOBlDKbDv3tiewbPOKD5JhezpTIy3dp/1eenMzH7zvq/1shv8LBT0NFHZxmdmfUxwJUsZJFVdK/knT7XDvLkCTTpaOCCYzSagjvJ1BCtTKbfnIKvAHjm1I0jlgWUGvZPOerwVbchadCCnUdOe2FMaabUDHNZneVExnsMvjHvWnA/9n5lo9DisfEXxa4QlvxGkbceiZ8XgoHFA5lvkdFBNP5QA8jaLZ+rdEIdR4UVz34+nA1RjYqbZjx6XMCY7N2VWi8cEPEzdmBxoRErvgPbB+ieHkrFBF93s2o3K2wJDkqUgmngUHP1U0vdgeB+rJLcIoFxj9gQ6K04YKiEbUG8gLtsjUryE1bYMWvNDeqxejbyRsRmfuwYC1/2Uyh3p7mwWLqf/ZZbCdqIyT2xRrA2ch+KxCnuRbZWEOeAWUaP+jNO6AwFiA4IyrNBSJe/bnmUDnFdcsClHuRe+GguXbiP1z6dJCpkQ8W+uZzN1ROFIrKz0Ru9oDXLz7XHC2z/VBKiq6wOzqDomC+hefS8iQloxzgg6GJrqNAbFFp46etL5B0jqALNGjmS87C7ouGiSgH4ftEyYASaU3CtpxMXyTQpjlcvyINNSQWX/qMmqjI59cddgXNj25FrcIVKAukRVkT7T28amTBm6AO9j2m9EU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(39830400003)(136003)(376002)(346002)(66556008)(786003)(66946007)(9686003)(6512007)(41320700001)(8936002)(6916009)(6486002)(54906003)(66476007)(8676002)(478600001)(316002)(4326008)(2906002)(86362001)(38100700002)(6666004)(33716001)(52116002)(41300700001)(5660300002)(83380400001)(6506007)(186003)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yo+KBKXuY7LosQLSSCGeMStccDW+T6Fhh5EuqIpH5Nd4VX77bLngUAYPt4ah?=
 =?us-ascii?Q?hygWNXvoTa/wKHldieKOrbFFm3QS/dKce/FkINib4KyC8V5P5/Qs2f/D5YKp?=
 =?us-ascii?Q?4cGxXtCMW0RBK/N4W3OobbiPnDOzqGK8QHWmzf//Sbd1UIDh2KTFg5xegUnj?=
 =?us-ascii?Q?cSHR8qw5Di0Xb5cdwYr5Yn9c7Umb6vJs0YmnO2oq/LSHVkPhre7J6FAToKXm?=
 =?us-ascii?Q?cXzikHS+0nfROJuecOOgGZO5LCP7l5xm8n4mCUj+KmBYbwggCxWtrQNi5GDR?=
 =?us-ascii?Q?9kfOCsFIiWExw6qs5uI+LvZgUNhoMzU8UIgXCqWj5TiTKihgkducFQraS1je?=
 =?us-ascii?Q?0F2a2tfxpUW4BGrJ+GLtLk4ezEtuT202aypUcFKvxQrN7h3fPHx2FTAbFcOQ?=
 =?us-ascii?Q?a5rIF2wUXXYaOIoYh0plymJrhOoiolg/y6SHq2avyrKS8tYxQ5F5Qa08cK1V?=
 =?us-ascii?Q?HQzxb37SI0YHMIWGko/btEtIu4BVT9xQvVmz87OL7RKnc5bEyzsiVcx5vcup?=
 =?us-ascii?Q?Y/9g8zujWx/qPPvbT3GTCRCwePSyxSk+WNGQqAsCiOFX8DDIEP/NkvHAqFiM?=
 =?us-ascii?Q?AmyS9MkdUUl6WNMTy2WKmKzap6aVxj2hlhGZ62YUUY25w8Fy+Pxqyu4WvVSK?=
 =?us-ascii?Q?XNjRwbiVMu0Y6OIVoKyUakfyCEVCK5wcWOVZxvFHFkz2H7djiR047QNqHHQo?=
 =?us-ascii?Q?FXq25rH0e46UOo68YvRvFSIkle3dTB6hYa9z7Ut/6j5CRl53cqhP+U/maA55?=
 =?us-ascii?Q?p9fVg0B0FjJcbfy4OXVh4gAz7WbVo8bxT9OoeLC+HAMofJ9lR2e1N0jv4PO4?=
 =?us-ascii?Q?nlZcdLwr6yUdV+26nWdM5syQzwWiTkyfTdpXHZbXZcgHQV3NGV9Elg4X4RB9?=
 =?us-ascii?Q?tWy/I4CVL+/OvxiC1xpUgN7aEeGAQJN1MbF0vgRDHxl7jqPVdeo03TVEqWXx?=
 =?us-ascii?Q?5mZnX9EjSnffKPKIhpZTpt4bt6van61aNmCqFwKLqk8lm83nL2sHv6VsBtqB?=
 =?us-ascii?Q?W8z1tbhL+SdnB8RjcMroBOTD5cfe1THznvAtZp9HpGumklMqw0OKsKR4rucK?=
 =?us-ascii?Q?BRGMLYBWvCgTLeloopTs5XmmW4AFprIgHcEw+WKk4dHoB27Wo7q0RSyqYIHn?=
 =?us-ascii?Q?8R06xfjb26Fid11or6dhjwLsUuWvi62OURkwBjuJcupqxHeAw5EPh1iorzI/?=
 =?us-ascii?Q?bQPWAiiU2S1pS3KHfO2p4O9qL7lBEAmWv+PDSsfT/PdztAOYNSt4J1e4UeI6?=
 =?us-ascii?Q?OfohcOflgSasjenE15KjRfCrpGRIfYUywdVLuUHH05VyE2c0w84SB+jS5mCx?=
 =?us-ascii?Q?IaCedahoeSgEjg8obLN8Von1UQyQP+Pd8b8dZ3vNtj3bKHLR0tBqGCp4g3r8?=
 =?us-ascii?Q?K8FtLQc3cW0naFgKICqP6bv6t5A4wkiD5aKDySTpJ9ax3SZLTU1PyvXXkYs3?=
 =?us-ascii?Q?6bAgK5ZQt1Taz4QuEttVA0do40LN/WOSRdCMfkbTmhfqvw/SeqHKFPfI1JkT?=
 =?us-ascii?Q?IqIuZZQlUYyeky2eaWUDytv/KHQvhAhzGFWzNniImKMpytnTGR0nhkCAWAbl?=
 =?us-ascii?Q?76fBoJwLTVFh4MX2yLgfITReNgt3dRpW6MD0WiguRak7RiWZIWvmFOLVnIt6?=
 =?us-ascii?Q?JvH3hVGJH4i3mbaNF1jjDWOwde6bJMThfYmpqmBtNmvHCzHyRVkngEJ94l8q?=
 =?us-ascii?Q?79JSii/CNonl8DYAsiVL2360ORcUZIvEMtxhSDzQ8RerauM9uPSmCH+2Byrw?=
 =?us-ascii?Q?pzy40G0SKA=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: f209cd50-3c75-4c65-bd97-08da553e1fcc
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 17:30:54.5856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XBJY6VZe8shEwniRRAIAacZpWAk3NCuK+nbiWXMrlqzxRrIC8TdZQKOGgkcbeG1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB0861
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Jun 10, 2022 at 05:33:35PM -0400, Rhett Aultman wrote:
> 
> In order to have all the flags in numerical order, URB_DIR_IN is
> renumbered from 0x0200 to 0x0400 so that URB_FREE_COHERENT can reuse
> value 0x0200.

>  #define URB_FREE_BUFFER		0x0100	/* Free transfer buffer with the URB */
> +#define URB_FREE_COHERENT	0x0200  /* Free DMA memory of transfer buffer */
>  
>  /* The following flags are used internally by usbcore and HCDs */
> -#define URB_DIR_IN		0x0200	/* Transfer from device to host */
> +#define URB_DIR_IN		0x0400	/* Transfer from device to host */
>  #define URB_DIR_OUT		0
>  #define URB_DIR_MASK		URB_DIR_IN
>  
> -- 
> 2.30.2
>

I'm afraid this is a change of uapi as this field is, unfortunately,
exported by usbip to userspace as TCP packets.

This may also cause incompatibility (surprisingly not for this case,
detailed below) between usbip server and client
when one kernel is using the new flags and the other one is not.

If we do change this, we may need to bump usbip protocol version
accordingly.

A copy of Alan Stern's suggestion here for reference
> I don't see anything wrong with this, except that it would be nice to keep 
> the flag values in numerical order.  In other words, set URB_FREE_COHERENT 
> to 0x0200 and change URB_DIR_IN to 0x0400.
> 
> Alan Stern

In usbip, an URB is packed by client (vhci)
into a TCP packet by usbip_pack_cmd_submit,
in which transfer_flags is copied almost as-is,
except it clears the DMA flag.
Then the server (usbip-host) would accept
the packet, mask some flags and
re-submit_urb to usbcore.

In usbip protocol, URB_DIR_IN is not used
as it has a `direction' field, the in-kernel
implementation (usbip-host) also does not
use it as when re-submit_urb the usb_submit_urb
will calculate this specific bit again.

For FREE_COHERENT, since DMA flag is
cleared, it does not affect the protocol
if both server and client are using the new version.

If we are using vhci in newer kernel and
the other side is using the old version,
the USB_FREE_COHERENT flag would be 0x0200,
and will be transmitted via TCP/IP to usbip-host
or a userspace implementation (there are many of them),
which will perceive it as URB_DIR_IN.
usbip-host is not affected, but userspace
program might be affected.

If we are using vhci in old kernel, and
the other side is using the new version,
all the URB_DIR_IN would be conceived by
usbip-host as USB_FREE_COHERENT.
Fortunately, it will be masked by
masking_bogus_flags in stub_rx.c,
and usbip-host will behave correctly,
but userspace program might be affected.

From the analysis above it turned
out that this change does not affect
in-kernel usbip implementation, but in a
quite tricky way.

One way to solve this issue for usbip
is to add some boilerplate transform
from URB_* to USBIP_FLAGS_*
as it is de facto uapi now.

Another way is to use 0x0400 for FREE_COHERENT.
usbip will not take care of this bit as
it would be masked.

Cc Shuah Khan here since she is the maintainer
on usbip.

Regards,

Hongren
