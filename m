Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6616109FEF
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2019 15:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKZOJg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Nov 2019 09:09:36 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36444 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfKZOJg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Nov 2019 09:09:36 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAQE9QF2042802;
        Tue, 26 Nov 2019 08:09:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574777366;
        bh=fe7neoi3txv1HuiXCnfcVQOEbV77V6sdrGfrbsQ4ehY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZLD0TAbJ+j8Op6lrsKhKh43ByEYqZPH2QXUSW4PnU+HHgIZoub+u+7056RDYAx8Sw
         LI1IhJ1O4Wqo3qaSfm27T9b+LExLfUt6uifkuVhq8B+Sut6wnD1R+LJIw2PnABES/D
         bp7qJExI4H2Zq9nxteJVS5UFQLDEKNNWKig8bUHc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAQE9QV1065762
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Nov 2019 08:09:26 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 26
 Nov 2019 08:09:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 26 Nov 2019 08:09:25 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAQE9PAo027828;
        Tue, 26 Nov 2019 08:09:25 -0600
Subject: Re: Devicetree for can tcan4x5x
To:     Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <e5892c08-03a5-60a6-61e0-6b75e248e172@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <eb7aaa46-3cc8-4ed3-adcf-aaa95c8dd197@ti.com>
Date:   Tue, 26 Nov 2019 08:07:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e5892c08-03a5-60a6-61e0-6b75e248e172@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 11/25/19 7:21 AM, Sean Nyekjaer wrote:
> Hi Dan and Marc,
>
> I'm testing a mockup with the iMX6ull and TCAN4x5x for CANFD 
> functionality.
>
> In our devicetree I'm having this entry:
> &ecspi1 {
>
>         cs-gpios = <&gpio4 26 0>;
>
>         pinctrl-names = "default";
>
>         pinctrl-0 = <&pinctrl_spi1>;
>
>
>
>         tcan4x5x: tcan4x5x@0 {
>
>                 compatible = "ti,tcan4x5x";
>
>                 reg = <0>;
>
>                 #address-cells = <1>;
>
>                 #size-cells = <1>;
>
>                 spi-max-frequency = <10000000>;
>
>                 bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
>
>                 interrupt-parent = <&gpio1>;
>
>                 interrupts = <23 GPIO_ACTIVE_LOW>;
>
>                 reset-gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
>
>         };
>
> };
>
> But it's not probing.
> The Documnetation [0] states I need some m_can entry, when looking in 
> [1] i looks like I'm creating a m_can device on the address/data bus.
>
> Do we have an m_can example for the tcan device?

Is the driver enabled in your .config?

Are the m_can drivers enabled?

Dan


