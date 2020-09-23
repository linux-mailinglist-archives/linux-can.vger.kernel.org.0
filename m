Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D464F275268
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 09:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIWHpc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 03:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWHpc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 03:45:32 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1748BC061755
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2020 00:45:32 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AF6A023E3F;
        Wed, 23 Sep 2020 09:45:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600847125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikrFAGljPsEPryiBkDhPtWwusUSzFmmI5t910r415ls=;
        b=Z3nZm2iRXk8nFhGNRFH+oKhzpzaFsymkuBh+aJoLrPrH8autv84oalvAYka33Izd54/aW4
        jTDixAo+uoQ4DCCSfr5eeqR/J0pSoZDcMSRe4Acmc46Yst5n4l2aux8WRE5jXyTpd7V8BE
        AL2ayHImvzmZ+bxITuqA40Lsr1U22lE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Sep 2020 09:45:25 +0200
From:   Michael Walle <michael@walle.cc>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH 20/20] can: flexcan: add lx2160ar1 support
In-Reply-To: <20200922144429.2613631-21-mkl@pengutronix.de>
References: <20200922144429.2613631-1-mkl@pengutronix.de>
 <20200922144429.2613631-21-mkl@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <4ffe89fbb4c91a9587622862c3509180@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Joakim, Hi Marc,

Am 2020-09-22 16:44, schrieb Marc Kleine-Budde:
> From: Joakim Zhang <qiangqing.zhang@nxp.com>
> 
> The Flexcan on lx2160ar1 supports CAN FD protocol.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> Link: 
> https://lore.kernel.org/r/20190712075926.7357-9-qiangqing.zhang@nxp.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/flexcan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 5f778c961a0c..e86925134009 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -216,6 +216,7 @@
>   *   MX8QM FlexCAN3  03.00.23.00    yes       yes        no       no
>      yes          yes
>   *   VF610 FlexCAN3  ?               no       yes        no      yes
>      yes?          no
>   * LS1021A FlexCAN2  03.00.04.00     no       yes        no       no
>      yes           no
> + * LX2160A FlexCAN3  03.00.23.00     no       yes        no       no
>      yes          yes

I'd really like to see LS1028A support. At the moment, I'm having the
following additional patch for the ls1028a device tree.

can0: can@2180000 {
     compatible = "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-flexcan";
     reg = <0x0 0x2180000 0x0 0x10000>;
     interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
                   clocks = <&sysclk>, <&clockgen 4 1>;
                   clock-names = "ipg", "per";
                   status = "disabled";
};

Do we need to add a dedicated compatible entry for the LS1028A
the driver?

-michael
