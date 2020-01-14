Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D429139E4C
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2020 01:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgANAdf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Jan 2020 19:33:35 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41388 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgANAdf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2020 19:33:35 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so10175490oie.8
        for <linux-can@vger.kernel.org>; Mon, 13 Jan 2020 16:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fXJN2b85yGTyfLCLDYBimi22Hg8WM/nHD10wRzYfTm4=;
        b=dJrsz2TLVvrm83NqLYbwA6TImUfTFWxZO9Fv73rwlHL+APLafjfIV2rBbPCh+4KBAk
         qs8iYgh3UAA+Z87cT2pHtCu9g3OdRcf1U/1Cz1C8StwQOG/U3jfq/tZVD4SGqmPakTUw
         CGgdnFmsqw5BxqgAsS6n4dPROaY+50hmdBmra8OabRFlJtmXMc5eb0/LMI3Lqa2Q3c1d
         0Ue45kYASrci5WSgM0ps9Z8b/sSB2uZSiKXykkxur4Nyd73qb1ExPxX9MJUv1hzdCsv6
         k+O6tCYizp6OMrezf2Ym7vzVjze5WTmGObYUFxsfKkh6NmUe51nmpo8P/5TqEICU8n3Z
         v1JQ==
X-Gm-Message-State: APjAAAUL/gg6z/6RAOMCp41paltP7+z4RNWa/+/pJ5S3ui4aHOvAYDb/
        dctfKJpeOPn43tRjWPncZwntoSeEpg==
X-Google-Smtp-Source: APXvYqxSx5cDx4Ps0AjJ26MFmY7d7q8M5Thgu7KGH/gp64TypV8A2P7gdkOwvXU8JLUpWHZt2cWYsA==
X-Received: by 2002:aca:33d5:: with SMTP id z204mr14015177oiz.120.1578962014321;
        Mon, 13 Jan 2020 16:33:34 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a24sm4086263oic.10.2020.01.13.16.33.32
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:33:33 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:33:32 -0600
Date:   Mon, 13 Jan 2020 18:33:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 15/17] dt-bindings: arm: add sam9x60-ek board
Message-ID: <20200114003332.GA3401@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-16-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-16-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 10 Jan 2020 18:18:07 +0200, Claudiu Beznea wrote:
> Add documentation for SAM9X60-EK board.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
