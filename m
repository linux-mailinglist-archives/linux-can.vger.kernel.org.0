Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5DA115154
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 14:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfLFNto (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 08:49:44 -0500
Received: from first.geanix.com ([116.203.34.67]:36330 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfLFNto (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 6 Dec 2019 08:49:44 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id D3E6D3DA;
        Fri,  6 Dec 2019 13:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575640176; bh=waN3ttaHT209uBiRNoHeJdUD5xOH/uL1mu/JWXxRLMU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fhYeItuMR7DKQfjA8DgsU/h2CqmlZ0qIi17zmKCv1EH8QNS3R7dIE6UPufjsvYcGY
         PJFb59Bl2aCVzEmQ5tgwPOemARzqlsG28fnB2XlxCHEFwJRkXuVXz2JOy6d8djoQsA
         D0xm43pCORi2RoAqWG3CZgjCuvk92BjTwEeRMeyrZ0LqGFUDcf4G9i3mBqmIf5ZVkp
         lBVHjmIyF89rUx9dfuOkabr6kTbFb3ZPqc1SLvZSG0gE746/ML0pl1+j0AfjiZwp6E
         L8k2b1yu/7ZKWoV78PhLNFsLaTYZNxxoJ593USZEjixVJsDfq3U5ezZvB/q9UiHpzl
         4gTciUAjlQ6Kw==
Subject: Re: [PATCH 1/2] dt-bindings: tcan4x5x: Make wake-gpio an optional
 gpio
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20191204175112.7308-1-dmurphy@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <f9b0e2ad-1d62-2c5a-fdce-c03205c2a9f7@geanix.com>
Date:   Fri, 6 Dec 2019 14:49:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191204175112.7308-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 04/12/2019 18.51, Dan Murphy wrote:
> The wake-up of the device can be configured as an optional
> feature of the device.  Move the wake-up gpio from a requried
> property to an optional property.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> CC: Rob Herring <robh@kernel.org>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> index 27e1b4cebfbd..7cf5ef7acba4 100644
> --- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> @@ -10,7 +10,6 @@ Required properties:
>   	- #size-cells: 0
>   	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
>   			     operate at should be less than or equal to 18 MHz.
> -	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
>   	- interrupt-parent: the phandle to the interrupt controller which provides
>                       the interrupt.
>   	- interrupts: interrupt specification for data-ready.
> @@ -23,6 +22,7 @@ Optional properties:
>   		       reset.
>   	- device-state-gpios: Input GPIO that indicates if the device is in
>   			      a sleep state or if the device is active.
> +	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
>   
>   Example:
>   tcan4x5x: tcan4x5x@0 {
> 
