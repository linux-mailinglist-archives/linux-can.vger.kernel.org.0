Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF60815D55E
	for <lists+linux-can@lfdr.de>; Fri, 14 Feb 2020 11:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgBNKSR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 Feb 2020 05:18:17 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:39693 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgBNKSR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Feb 2020 05:18:17 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2B44A23E5A;
        Fri, 14 Feb 2020 11:18:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1581675494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/eX7aayklkOMJ3Haoq+/KSOMNylP/B8TjOGspo0FXs=;
        b=VPiuwUdm2kx2JXgIu8ql7y5ellgzgtdkWEyEPqyXwNsV2X0axaTXWN6RcDCYuhgErjHBtP
        h8AcyiObneW4KhKFEKsGV6cDEWW8RB7ZBjAhMlmDVRfD7AV/bEhFhE31TNGNDds3/pDUsp
        uMQ2t4yUPS9elLQf+pB6i2YP+TLrE5Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 14 Feb 2020 11:18:14 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pankaj Bansal <pankaj.bansal@nxp.com>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com,
        netdev@vger.kernel.org, linux-can@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 0/8] can: flexcan: add CAN FD support for NXP Flexcan
In-Reply-To: <VI1PR0401MB2496CE72BC7FB91AD2C2685CF1150@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <24eb5c67-4692-1002-2468-4ae2e1a6b68b@pengutronix.de>
 <20200213192027.4813-1-michael@walle.cc>
 <DB7PR04MB461896B6CC3EDC7009BCD741E6150@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <2322fb83486c678917957d9879e27e63@walle.cc>
 <DB7PR04MB46187A6B5A8EC3A1D73D69FFE6150@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <bf671072ce479049eb354d44f3617383@walle.cc>
 <VI1PR0401MB2496CE72BC7FB91AD2C2685CF1150@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Message-ID: <66d741b8d01f6d2cc2473172a6d550c2@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: /
X-Spam-Status: No, score=-0.10
X-Rspamd-Server: web
X-Spam-Score: -0.10
X-Rspamd-Queue-Id: 2B44A23E5A
X-Spamd-Result: default: False [-0.10 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.892];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 2020-02-14 11:01, schrieb Pankaj Bansal:
> Hi Michael,
> 
>> -----Original Message-----
>> From: Michael Walle <michael@walle.cc>
>> Sent: Friday, February 14, 2020 3:03 PM
>> To: Joakim Zhang <qiangqing.zhang@nxp.com>
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>; wg@grandegger.com;
>> netdev@vger.kernel.org; linux-can@vger.kernel.org; Pankaj Bansal
>> <pankaj.bansal@nxp.com>; Shawn Guo <shawnguo@kernel.org>
>> Subject: Re: [PATCH 0/8] can: flexcan: add CAN FD support for NXP 
>> Flexcan
>> 
>> Am 2020-02-14 10:18, schrieb Joakim Zhang:
>> > Best Regards,
>> > Joakim Zhang
>> >
>> >> -----Original Message-----
>> >> From: Michael Walle <michael@walle.cc>
>> >> Sent: 2020年2月14日 16:43
>> >> To: Joakim Zhang <qiangqing.zhang@nxp.com>
>> >> Cc: Marc Kleine-Budde <mkl@pengutronix.de>; wg@grandegger.com;
>> >> netdev@vger.kernel.org; linux-can@vger.kernel.org; Pankaj Bansal
>> >> <pankaj.bansal@nxp.com>
>> >> Subject: Re: [PATCH 0/8] can: flexcan: add CAN FD support for NXP
>> >> Flexcan
>> >>
>> >> Hi Joakim,
>> >>
>> >> Am 2020-02-14 02:55, schrieb Joakim Zhang:
>> >> > Hi Michal,
>> >> >
>> >> >> -----Original Message-----
>> >> >> From: Michael Walle <michael@walle.cc>
>> >> >> Sent: 2020年2月14日 3:20
>> >> >> To: Marc Kleine-Budde <mkl@pengutronix.de>
>> >> >> Cc: Joakim Zhang <qiangqing.zhang@nxp.com>; wg@grandegger.com;
>> >> >> netdev@vger.kernel.org; linux-can@vger.kernel.org; Pankaj Bansal
>> >> >> <pankaj.bansal@nxp.com>; Michael Walle <michael@walle.cc>
>> >> >> Subject: Re: [PATCH 0/8] can: flexcan: add CAN FD support for NXP
>> >> >> Flexcan
>> >> >>
>> >> >> Hi,
>> >> >>
>> >> >> >>> Are you prepared to add back these patches as they are
>> >> >> >>> necessary for Flexcan CAN FD? And this Flexcan CAN FD patch
>> >> >> >>> set is based on these patches.
>> >> >> >>
>> >> >> >> Yes, these patches will be added back.
>> >> >> >
>> >> >> >I've cleaned up the first patch a bit, and pushed everything to
>> >> >> >the testing branch. Can you give it a test.
>> >> >>
>> >> >> What happend to that branch? FWIW I've just tried the patches on a
>> >> >> custom board with a LS1028A SoC. Both CAN and CAN-FD are working.
>> >> >> I've tested against a Peaktech USB CAN adapter. I'd love to see
>> >> >> these patches upstream, because our board also offers CAN and
>> >> >> basic support for it just made it upstream [1].
>> >> > The FlexCAN CAN FD related patches have stayed in
>> >> > linux-can-next/flexcan branch for a long time, I still don't know
>> >> > why Marc doesn't merge them into Linux mainline.
>> >> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.
>> >> >
>> >> kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fmkl%2Flinux-can-
>> next.
>> >> g
>> >> >
>> >>
>> it%2Ftree%2F%3Fh%3Dflexcan&amp;data=02%7C01%7Cqiangqing.zhang%40n
>> >> xp.co
>> >> >
>> >>
>> m%7C94dca4472a584410b3b908d7b129db27%7C686ea1d3bc2b4c6fa92cd99c
>> >> 5c30163
>> >> >
>> >> 5%7C0%7C0%7C637172665642079192&amp;sdata=77tG6VuQCi%2FZXBKb23
>> >> 8%2FdNSV3
>> >> > NUIFrM5Y0e9yj0J3os%3D&amp;reserved=0
>> >> > Also must hope that this patch set can be upstreamed soon. :-)
>> >>
>> >> I've took them from this branch and applied them to the latest linux
>> >> master.
>> >>
>> >> Thus,
>> >>
>> >> Tested-by: Michael Walle <michael@walle.cc>
>> >>
>> >>
>> >> >> If these patches are upstream, only the device tree nodes seems to
>> >> >> be missing.
>> >> >> I don't know what has happened to [2]. But the patch doesn't seem
>> >> >> to be necessary.
>> >> > Yes, this patch is unnecessary. I have NACKed this patch for that,
>> >> > according to FlexCAN Integrated Guide, CTRL1[CLKSRC]=0 select
>> >> > oscillator clock and CTRL1[CLKSRC]=1 select peripheral clock.
>> >> > But it is actually decided by SoC integration, for i.MX, the design
>> >> > is different.
>> >>
>> >> ok thanks for clarifying.
>> >>
>> >> > I have not upstream i.MX FlexCAN device tree nodes, since it's
>> >> > dependency have not upstreamed yet.
>> >> >
>> >> >> Pankaj already send a patch to add the device node to the LS1028A [3].
>> >> >> Thats basically the same I've used, only that mine didn't had the
>> >> >> "fsl,ls1028ar1-flexcan" compatiblity string, but only the
>> >> >> "lx2160ar1-flexcan"
>> >> >> which is the correct way to use it, right?
>> >> > You can see below table from FlexCAN driver, "fsl,lx2160ar1-flexcan"
>> >> > supports CAN FD, you can use this compatible string.
>> >>
>> >> correct. I've already a patch that does exactly this ;) Who would
>> >> take the patch for adding the LS1028A can device tree nodes to
>> >> ls1028a.dtsi? You or Shawn Guo?
>> > Sorry, I missed the link[3], we usually write it this way:
>> > 			compatible = "fsl,ls1028ar1-flexcan","fsl,lx2160ar1-
>> flexcan";
>> > Please send patch to Shawn Guo, he will review the device tree.
>> 
>> As far as I know, there should be no undocumented binding. Eg. the 
>> ls1028ar1-
>> flexcan is neither in the source nor in the device tree binding 
>> documentation,
>> thus wouldn't be accepted.
>> 
>> Thus either there should be another ls1028ar1-flexcan in the 
>> flexcan_of_match
>> table and the node should only contain that string or the node should 
>> only
>> contain fsl,lx2160ar1-flexcan. Is there any advantage of the first 
>> option?
>> 
> 
> This is done to ensure that device tree bindings are stable.
> See this talk for more information for stable device tree ABI:

Thanks, yes that makes sense, actually I'd have done it the same way. I 
was
just wondering about the "it has to be documented"; as Joakim pointed 
out, thats
easy here, because there is the template here, eg. 
"fsl,<processor>-flexcan".

-michael

> 
> https://elinux.org/images/0/0e/OSELAS.Presentation-ELCE2017-DT.pdf
> https://www.youtube.com/watch?v=6iguKSJJfxo
> 
>> 
>> -michael
>> 
>> 
>> >
>> >> > static const struct of_device_id flexcan_of_match[] = {
>> >> > 	{ .compatible = "fsl,imx8qm-flexcan", .data =
>> >> > &fsl_imx8qm_devtype_data, },
>> >> > 	{ .compatible = "fsl,imx6q-flexcan", .data =
>> >> > &fsl_imx6q_devtype_data, },
>> >> > 	{ .compatible = "fsl,imx28-flexcan", .data =
>> >> > &fsl_imx28_devtype_data, },
>> >> > 	{ .compatible = "fsl,imx53-flexcan", .data =
>> >> > &fsl_imx25_devtype_data, },
>> >> > 	{ .compatible = "fsl,imx35-flexcan", .data =
>> >> > &fsl_imx25_devtype_data, },
>> >> > 	{ .compatible = "fsl,imx25-flexcan", .data =
>> >> > &fsl_imx25_devtype_data, },
>> >> > 	{ .compatible = "fsl,p1010-flexcan", .data =
>> >> > &fsl_p1010_devtype_data, },
>> >> > 	{ .compatible = "fsl,vf610-flexcan", .data =
>> >> > &fsl_vf610_devtype_data, },
>> >> > 	{ .compatible = "fsl,ls1021ar2-flexcan", .data =
>> >> > &fsl_ls1021a_r2_devtype_data, },
>> >> > 	{ .compatible = "fsl,lx2160ar1-flexcan", .data =
>> >> > &fsl_lx2160a_r1_devtype_data, },
>> >> > 	{ /* sentinel */ },
>> >> > };
>> >> >
>> >>
>> >> -michael
