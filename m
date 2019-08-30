Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69E36A39DD
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2019 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfH3PFG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 30 Aug 2019 11:05:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34982 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfH3PFF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 30 Aug 2019 11:05:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7UF4sOo010446;
        Fri, 30 Aug 2019 10:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567177494;
        bh=vGcpWtukrbpuDBpmlVsjWrokX3hrE5cSHe33YFa+CcY=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=gVtoCFXjsA3qhnPQ1Z4AN8MQj1vDs1Y54cFHfU/+ztnlb2JWQ5Smhjpce82ATVHiN
         rYUwTRv2fs1Y5INkNpq0WixIishfRYh78tJPEkN2041bClK3mVsILkwAzQ59h48ky+
         jWpCszqFyw7WGFcQjc+T82jtqUXDlKqFTImqWLKo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7UF4skv075525
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Aug 2019 10:04:54 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 30
 Aug 2019 10:04:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 30 Aug 2019 10:04:53 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7UF4r9w119892;
        Fri, 30 Aug 2019 10:04:53 -0500
Subject: Re: [PATCH 1/3] dt-bindings: can: tcan4x5x: Update binding to use
 interrupt property
To:     <linux-can@vger.kernel.org>, <mkl@pengutronix.de>,
        <davem@davemloft.net>, <wg@grandegger.com>
References: <20190823175058.7442-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <198c7ca1-c8c8-379e-f63d-4b8c0f0692fc@ti.com>
Date:   Fri, 30 Aug 2019 10:04:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823175058.7442-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 8/23/19 12:50 PM, Dan Murphy wrote:
> Remove the data-ready-gpio property in favor of the DT standard
> interrupt-parent and interrupts.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Since we are changing the binding we should probably get this series in 
before the first patch series gets into mainline.

Dan


> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> index c388f7d9feb1..27e1b4cebfbd 100644
> --- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> @@ -10,8 +10,10 @@ Required properties:
>   	- #size-cells: 0
>   	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
>   			     operate at should be less than or equal to 18 MHz.
> -	- data-ready-gpios: Interrupt GPIO for data and error reporting.
>   	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
> +	- interrupt-parent: the phandle to the interrupt controller which provides
> +                    the interrupt.
> +	- interrupts: interrupt specification for data-ready.
>   
>   See Documentation/devicetree/bindings/net/can/m_can.txt for additional
>   required property details.
> @@ -30,7 +32,8 @@ tcan4x5x: tcan4x5x@0 {
>   		#size-cells = <1>;
>   		spi-max-frequency = <10000000>;
>   		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
> -		data-ready-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <14 GPIO_ACTIVE_LOW>;
>   		device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
>   		device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
>   		reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
