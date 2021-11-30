Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19636462A66
	for <lists+linux-can@lfdr.de>; Tue, 30 Nov 2021 03:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhK3C3D (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 Nov 2021 21:29:03 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40834 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhK3C3D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Nov 2021 21:29:03 -0500
Received: by mail-ot1-f43.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so28210623otj.7;
        Mon, 29 Nov 2021 18:25:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ElFmPv7JbuuvLjUrqcnZO/2cEbx3P5Wj/MSTTRUbYY=;
        b=sHQTLOTDvO1CEv9fn59cU6ZR1aRMypHSXcVx5aiFjP2372ahE8KImIKNEfQxRlmsIn
         WLMzTm36FXhAhzj1Bs3BzZbW1W0Q9ew2bmd6IDC+rrcY4GZ9MqzmnF2aiw6Ysj/aK3yW
         j9yjvKEhr9XJAOOxvmofyB24ZH7QB8DUzJYLe3lvwSDr96NQBc8bhzymIRXBDOTEJbva
         6vWRIbhPm4JRd+Dbz3VVJWoJKwz07SkdV5jPsnYCJpj7Im+xCdgcf/cBMTh7UU5DAlni
         MuK0MUID3izc8tbc+UV5Ee6Dh569vih38qvLKgrJoc1x00uqtCZMgUX4FGNbetjFpHfd
         0ZtQ==
X-Gm-Message-State: AOAM533AJ0px7Akbb0cfP34pXTSBz67xnlBti61RgTGhav+nOXZwnR+Z
        UPaSszsvizc+mJh8oN2ezw==
X-Google-Smtp-Source: ABdhPJyoJ1gzjMOXZ3xcw5zLSd2nLS0/d3pcsNJcQl7lCz14mLeHkInH7RKZOvr6grFRxjXam9DzUA==
X-Received: by 2002:a9d:4f0b:: with SMTP id d11mr47950681otl.227.1638239144207;
        Mon, 29 Nov 2021 18:25:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 186sm3385109oig.28.2021.11.29.18.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:25:43 -0800 (PST)
Received: (nullmailer pid 1056381 invoked by uid 1000);
        Tue, 30 Nov 2021 02:25:42 -0000
Date:   Mon, 29 Nov 2021 20:25:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        linux-sunxi@lists.linux.dev,
        "David S . Miller" <davem@davemloft.net>,
        Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
        Chen-Yu Tsai <wens@csie.org>, linux-can@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-arm-kernel@lists.infradead.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: can: add support for Allwinner R40
 CAN controller
Message-ID: <YaWLpkkSse+BMHau@robh.at.kernel.org>
References: <20211122104616.537156-1-boger@wirenboard.com>
 <20211122104616.537156-2-boger@wirenboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122104616.537156-2-boger@wirenboard.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, 22 Nov 2021 13:46:14 +0300, Evgeny Boger wrote:
> Allwinner R40 (also known as A40i, T3, V40) has a CAN controller. The
> controller is the same as in earlier A10 and A20 SoCs, but needs reset
> line to be deasserted before use.
> 
> This patch Introduces new compatible for R40 CAN controller with
> required resets property.
> 
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
> ---
>  .../net/can/allwinner,sun4i-a10-can.yaml      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
