Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F676F3B54
	for <lists+linux-can@lfdr.de>; Tue,  2 May 2023 02:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjEBATB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 May 2023 20:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjEBATA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 May 2023 20:19:00 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C7BE7A;
        Mon,  1 May 2023 17:18:58 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3420IKXI070147;
        Mon, 1 May 2023 19:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682986700;
        bh=2xPdfbXKkI18fLVNxuoUgjV/EL3yFDxzUN/5cXRRZLI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Mp/GBj9c16keBA5h6AuWULyZfvxUqiRJBBzqLd4CLjResFov0q+TNRXLxarWevtAr
         45Wfog2h9QF8doTMlFTw8WKX19BYhTvqBLMjZxOVdi4ykSALiWZi1OBzrc07WU2l+u
         XhL3TtEg5n+72xSYecQs0U1+3kt97oAqmNELXxg0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3420IKTX056702
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 May 2023 19:18:20 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 May 2023 19:18:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 May 2023 19:18:19 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3420IJ8I011856;
        Mon, 1 May 2023 19:18:19 -0500
Date:   Mon, 1 May 2023 19:18:19 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Judith Mendez <jm@ti.com>
CC:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Schuyler Patton <spatton@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v4 3/4] DO_NOT_MERGE arm64: dts: ti: Add AM62x MCAN MAIN
 domain transceiver overlay
Message-ID: <20230502001819.ik3srlbfs663wuwg@harmful>
References: <20230501224624.13866-1-jm@ti.com>
 <20230501224624.13866-4-jm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230501224624.13866-4-jm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 17:46-20230501, Judith Mendez wrote:
> Add an overlay for main domain MCAN on AM62x SK. The AM62x
> SK board does not have on-board CAN transceiver so instead
> of changing the DTB permanently, add an overlay to enable
> MAIN domain MCAN and support for 1 CAN transceiver.
> 
> This DT overlay can be used with the following EVM:
> Link: https://www.ti.com/tool/TCAN1042DEVM
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> Changelog:
> v3:
>  1. Add link for specific board
>  
>  arch/arm64/boot/dts/ti/Makefile               |  2 ++
>  .../boot/dts/ti/k3-am625-sk-mcan-main.dtso    | 35 +++++++++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am625-sk-mcan-main.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index c83c9d772b81..abe15e76b614 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -9,8 +9,10 @@
>  # alphabetically.
>  
>  # Boards with AM62x SoC
> +k3-am625-sk-mcan-dtbs := k3-am625-sk.dtb k3-am625-sk-mcan-main.dtbo

NAK.
https://lore.kernel.org/all/4e406c96-3f47-1695-324f-a9e45be8c142@ti.com/

Same reasons - we don't want specific instance based overlays please -
that would'nt make sense - maxbitrate will depend on transceiver so it
has nothing to do with mcan-main or mcan-mcu and has everything to do
with the board that is plugged in.

>  dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am625-sk-mcan.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
>  
>  # Boards with AM62Ax SoC
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk-mcan-main.dtso b/arch/arm64/boot/dts/ti/k3-am625-sk-mcan-main.dtso
> new file mode 100644
> index 000000000000..0a7b2f394f87
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk-mcan-main.dtso

If you are going down this road: am625-sk-tcan10242d.dsto (enable main
and mcu?) or something reasonable. Though looking at the pins, I fail
to see how this physically plugs into AM625-SK (I am hoping the answer
isn't breadboard or jumper wires..).



> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * DT overlay for MCAN transceiver in main domain on AM625 SK
> + *
> + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include "k3-pinctrl.h"
> +
> +&{/} {
> +	transceiver1: can-phy0 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +	};
> +};
> +
> +&main_pmx0 {
> +	main_mcan0_pins_default: main-mcan0-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x1dc, PIN_INPUT, 0) /* (E15) MCAN0_RX */
> +			AM62X_IOPAD(0x1d8, PIN_OUTPUT, 0) /* (C15) MCAN0_TX */
> +		>;
> +	};
> +};
> +
> +&main_mcan0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan0_pins_default>;
> +	phys = <&transceiver1>;
> +};
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
