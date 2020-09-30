Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F74A27E4EF
	for <lists+linux-can@lfdr.de>; Wed, 30 Sep 2020 11:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgI3JSk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 30 Sep 2020 05:18:40 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33873 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgI3JSk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2020 05:18:40 -0400
Received: by mail-oi1-f194.google.com with SMTP id n2so969070oij.1;
        Wed, 30 Sep 2020 02:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jViT13SIgMbIyKXxOmi/53k8Cut8dOBbwqL9Imlo2og=;
        b=LB+bcHgwzrMmGnVjL8dUAmkiN26Ve2qudWkDzTPHqgef7ujDmvPTEFLLukRjmD/Dlj
         SGDixt9Yn2DAZwIlWiTQ0I7Q3BT0Ll8eNs3VPdfSw8kjEbdk+ZDqoBgSg0+Qg97avKKh
         x4jDuXk+laq+oE99BCCVuDNWQx1niUDSRDN0HNvVkY8rzC3yelx9GEnVniUGrpP3GNE0
         IjX6ydnf3zqBAhOtW9diphx6Ickzv3SUqibBg2KtS9lx3uOZ/hzLVIZUo6Ce9l9+0iTH
         oCxZ4rFJYw6PhGROCXtgRQYFeEOyqw6dOUy+EI4luhNk1bItU3bTq4lG0Nc6BWu4ea1k
         ck+Q==
X-Gm-Message-State: AOAM533QjxYi5vGomp2c7twXkI+MXfVXiuvqgQifNWvdS2PY/HpYcMuu
        0Y22M6c05BkkvaWl4w9eOeVxsSuy6HioAqBd9RUUc4xQ
X-Google-Smtp-Source: ABdhPJyFU9FuskdJqPNGcxqjL5h2yGhfFtu7x0RSFm2YwL+4e5LlXBxauRROs40Ev1Zlb/f2PUB0QGgejUD8U+gqMeY=
X-Received: by 2002:aca:52d6:: with SMTP id g205mr887849oib.54.1601457519644;
 Wed, 30 Sep 2020 02:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200930091424.792165-1-mkl@pengutronix.de> <20200930091424.792165-7-mkl@pengutronix.de>
In-Reply-To: <20200930091424.792165-7-mkl@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Sep 2020 11:18:28 +0200
Message-ID: <CAMuHMdU_-gL-J3MdR5nHg8KSM2ywPYdhjHFFE9nS9Wk1giDQ_A@mail.gmail.com>
Subject: Re: [PATCH 06/12] dt-binding: can: mcp251xfd: rename autodetect
 compatible to "microchip,mcp251xfd"
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

CC dt

On Wed, Sep 30, 2020 at 11:14 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> In [1] Geert noted that the autodetect compatible for the mcp25xxfd driver,
> which is "microchip,mcp25xxfd" might be too generic and overlap with upcoming,
> but incompatible chips.
>
> As the driver is in net-next but not mainline yet, the risk of breaking DT
> compatibility is quite low, so this patch changes the compatible to
> "microchip,mcp251xfd" and renames the binding documentation accordingly.
>
> [1] http://lore.kernel.org/r/CAMuHMdVkwGjr6dJuMyhQNqFoJqbh6Ec5V2b5LenCshwpM2SDsQ@mail.gmail.com
>
> Fixes: 1b5a78e69c1f ("dt-binding: can: mcp25xxfd: document device tree bindings")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  ...{microchip,mcp25xxfd.yaml => microchip,mcp251xfd.yaml} | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>  rename Documentation/devicetree/bindings/net/can/{microchip,mcp25xxfd.yaml => microchip,mcp251xfd.yaml} (91%)
>
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
> similarity index 91%
> rename from Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> rename to Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
> index 5beb00a614bf..2a884c1fe0e0 100644
> --- a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/net/can/microchip,mcp25xxfd.yaml#
> +$id: http://devicetree.org/schemas/net/can/microchip,mcp251xfd.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
>  title:
> @@ -18,7 +18,7 @@ properties:
>          description: for MCP2517FD
>        - const: microchip,mcp2518fd
>          description: for MCP2518FD
> -      - const: microchip,mcp25xxfd
> +      - const: microchip,mcp251xfd
>          description: to autodetect chip variant
>
>    reg:
> @@ -38,7 +38,7 @@ properties:
>
>    microchip,rx-int-gpios:
>      description:
> -      GPIO phandle of GPIO connected to to INT1 pin of the MCP25XXFD, which
> +      GPIO phandle of GPIO connected to to INT1 pin of the MCP251XFD, which
>        signals a pending RX interrupt.
>      maxItems: 1
>
> @@ -65,7 +65,7 @@ examples:
>          #size-cells = <0>;
>
>          can@0 {
> -            compatible = "microchip,mcp25xxfd";
> +            compatible = "microchip,mcp251xfd";
>              reg = <0>;
>              clocks = <&can0_osc>;
>              pinctrl-names = "default";
> --
> 2.28.0
