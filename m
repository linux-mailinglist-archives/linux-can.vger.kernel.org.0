Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F11108EB8
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2019 14:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfKYNWJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Nov 2019 08:22:09 -0500
Received: from first.geanix.com ([116.203.34.67]:59096 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfKYNWJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 25 Nov 2019 08:22:09 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 42BBA9324C;
        Mon, 25 Nov 2019 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1574687911; bh=HIbU12Gd2W2gdBc2jwWIRy6qgPyrplYVI8PgDlTYxZc=;
        h=To:Cc:From:Subject:Date;
        b=B7WW0JpLs+hSh/RNAr/L1TWdXsyzHoZoqb7FaY4ONfSl2EVTQHGUYVcqznADjAbnr
         UVqjWFE8WJBBxXFuQ9hRbXPfUf/p82biWxJObq9bHiAtlLL8gQGi9WpWjYUZRp89k2
         4H41MTHqJ4xAv1A6aDgQV243akbUgci4b7YMRl61Qg0O2Uj1im4hXYMsPyUGbMLfpR
         XcqJ3DGMUeeUkJTkauLii5aUnNJN+6yoMI4DqXF04X5TO0LhboJKoJMUbaJEvHpOiW
         hK60EktIY5C8t9INs152sh995e4Y4GkeBXmLkFxTKiYyfeGVa6vcbfouRcwyktIaVZ
         dkMiKtAAP0XoQ==
To:     dmurphy@ti.com, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Subject: Devicetree for can tcan4x5x
Message-ID: <e5892c08-03a5-60a6-61e0-6b75e248e172@geanix.com>
Date:   Mon, 25 Nov 2019 14:21:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b0d531b295e6
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Dan and Marc,

I'm testing a mockup with the iMX6ull and TCAN4x5x for CANFD functionality.

In our devicetree I'm having this entry:
&ecspi1 {

         cs-gpios = <&gpio4 26 0>;

         pinctrl-names = "default";

         pinctrl-0 = <&pinctrl_spi1>;



         tcan4x5x: tcan4x5x@0 {

                 compatible = "ti,tcan4x5x";

                 reg = <0>;

                 #address-cells = <1>;

                 #size-cells = <1>;

                 spi-max-frequency = <10000000>;

                 bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;

                 interrupt-parent = <&gpio1>;

                 interrupts = <23 GPIO_ACTIVE_LOW>;

                 reset-gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;

         };

};

But it's not probing.
The Documnetation [0] states I need some m_can entry, when looking in 
[1] i looks like I'm creating a m_can device on the address/data bus.

Do we have an m_can example for the tcan device?

I'm on the current linux-can-next testing branch.

/Sean

[0]: Documentation/devicetree/bindings/net/can/tcan4x5x.txt

[1]: Documentation/devicetree/bindings/net/can/m_can.txt
