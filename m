Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DC227840C
	for <lists+linux-can@lfdr.de>; Fri, 25 Sep 2020 11:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgIYJbw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Sep 2020 05:31:52 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:34285 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYJbw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Sep 2020 05:31:52 -0400
X-Greylist: delayed 171256 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 05:31:51 EDT
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 12DA622ED5;
        Fri, 25 Sep 2020 11:31:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1601026310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uLL/4PRlCphLUVIwMp3bEigo2LIKHqcXNDfV6nTtgZo=;
        b=LSXChYe0kWNHjGg7/AndycHtLLqVD7I0by/kWa6LC0RzaKZKCMBA76kPbpHy8Oppl2RVBc
        gUc+A+UtkJcSNamnHztPd6VrmQ2077GYyI1G5rKyKkBUr5alVlcS3L4Ij1EvVrtibBhwKY
        9DcVdsGlqU5zhG2wvva0aFof3MNY+98=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 25 Sep 2020 11:31:50 +0200
From:   Michael Walle <michael@walle.cc>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: ls1028a: add missing CAN nodes
In-Reply-To: <VE1PR04MB6687CF32DBCC76B4DFBA070A8F390@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20200923095711.11355-1-michael@walle.cc>
 <20200923095711.11355-2-michael@walle.cc>
 <VE1PR04MB6687AC23E100D138FEDB012A8F390@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <e9347e4c2e070ee9e8aa7a8007d89f02@walle.cc>
 <VE1PR04MB6687CF32DBCC76B4DFBA070A8F390@VE1PR04MB6687.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <cd04c75c5d92371eca86d269cb17bcb3@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 2020-09-24 17:53, schrieb Leo Li:
>> -----Original Message-----
>> From: Michael Walle <michael@walle.cc>
>> Sent: Thursday, September 24, 2020 6:31 AM
>> To: Leo Li <leoyang.li@nxp.com>
>> Cc: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; 
>> linux-
>> kernel@vger.kernel.org; linux-can@vger.kernel.org; Shawn Guo
>> <shawnguo@kernel.org>; Rob Herring <robh+dt@kernel.org>; Marc Kleine-
>> Budde <mkl@pengutronix.de>; Joakim Zhang <qiangqing.zhang@nxp.com>
>> Subject: Re: [PATCH 1/2] arm64: dts: ls1028a: add missing CAN nodes
>> 
>> Am 2020-09-24 02:35, schrieb Leo Li:
>> >> -----Original Message-----
>> >> From: Michael Walle <michael@walle.cc>
>> >> Sent: Wednesday, September 23, 2020 4:57 AM
>> >> To: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
>> >> linux-
>> >> kernel@vger.kernel.org; linux-can@vger.kernel.org
>> >> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>;
>> Rob
>> >> Herring <robh+dt@kernel.org>; Marc Kleine-Budde
>> <mkl@pengutronix.de>;
>> >> Joakim Zhang <qiangqing.zhang@nxp.com>; Michael Walle
>> >> <michael@walle.cc>
>> >> Subject: [PATCH 1/2] arm64: dts: ls1028a: add missing CAN nodes
>> >>
>> >> The LS1028A has two FlexCAN controller. These are compatible with the
>> >> ones
>> >> from the LX2160A. Add the nodes.
>> >>
>> >> The first controller was tested on the Kontron sl28 board.
>> >>
>> >> Signed-off-by: Michael Walle <michael@walle.cc>
>> >> ---
>> >>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 18
>> >> ++++++++++++++++++
>> >>  1 file changed, 18 insertions(+)
>> >>
>> >> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> >> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> >> index 0efeb8fa773e..807ee921ec12 100644
>> >> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> >> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> >> @@ -386,6 +386,24 @@
>> >>  			status = "disabled";
>> >>  		};
>> >>
>> >> +		can0: can@2180000 {
>> >> +			compatible = "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-
>> >> flexcan";
>> >
>> > The explicit compatible strings cannot be found in the binding, but
>> > matched by the "fsl,<processor>-flexcan" pattern in the binding.  Is
>> > this considered to be acceptable now?
>> 
>> What is the consequence if it is not acceptable? replacing the pattern
>> with individual compatible strings?
> 
> There is a recommendation in the kernel documentation quoted below:
> 
>   7) The wildcard "<chip>" may be used in compatible strings, as in
>      the following example:
> 
>          - compatible: Must contain '"nvidia,<chip>-pcie",
>            "nvidia,tegra20-pcie"' where <chip> is tegra30, tegra132, 
> ...
> 
>      As in the above example, the known values of "<chip>" should be
>      documented if it is used.
> 
> But I am not sure if this is still a hard requirement.  If so, we
> should list the processors in the binding.

Marc, I'd convert this to yaml format, may I put your name as the
maintainer in the binding?

-michael
