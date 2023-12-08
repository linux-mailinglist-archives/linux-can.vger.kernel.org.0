Return-Path: <linux-can+bounces-84-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20D080AC13
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 19:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF11281806
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 18:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F08249FB;
	Fri,  8 Dec 2023 18:31:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B174BD;
	Fri,  8 Dec 2023 10:31:03 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6d9f7af8918so218560a34.0;
        Fri, 08 Dec 2023 10:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702060262; x=1702665062;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v+yJeduNngKCWy3/DH0y84rogwCflce9ufqE8UYu448=;
        b=DTZWEvGkrzLRVyFaf2n1WVyiGQFjsweGp3Gj2cuBhEKA85U/g2mjBA9ZaICa72S0E8
         W26fuAQgdKhZ0VIr0Uvlt5xRsIPKzdrfhKhBAEF2E2YYg09TdYbHM94QbD7ougo3g0Bv
         uBrpSkQLCccLYUtHSBWxfOSb8n0hjSogSyR9a5KtHT+uG5x1Plc3J6U6DWAjyMKecWGA
         IbpIIgH4iJgW8MC/qXVA290UTny5ho6b/+QCJ1H92LYq+FOtJS49eZ6ImDYlb4la74PK
         aMBnxcnZGH2BwMyL1Mft0NZTj1aoTGcSy3/N1GC/2D82F9KrUlJ6FJRAMcYLE4gc7m/7
         CCrQ==
X-Gm-Message-State: AOJu0Yxlvsv6aTOM1rHC3XDS30O0NntO+L3zEY7VsXHSiqA9HCfV8Obp
	HI8k5CNbSi6GTay6kIpChg==
X-Google-Smtp-Source: AGHT+IHXtCU+Df3narf9EUnnld4MDBZ1SkRhwu+ygUAtS6Zf9h8UB7gij98jquMR2wdiE98NTVaiyA==
X-Received: by 2002:a05:6870:7029:b0:1fb:75b:2fd4 with SMTP id u41-20020a056870702900b001fb075b2fd4mr579114oae.107.1702060262327;
        Fri, 08 Dec 2023 10:31:02 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id hb5-20020a056870780500b001fb1e0a25e8sm507468oab.26.2023.12.08.10.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:31:01 -0800 (PST)
Received: (nullmailer pid 2485978 invoked by uid 1000);
	Fri, 08 Dec 2023 18:31:00 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, Daire McNamara <daire.mcnamara@microchip.com>, Wolfgang Grandegger <wg@grandegger.com>, Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org, Eric Dumazet <edumazet@google.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20231208-palpitate-passable-c79bacf2036c@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
 <20231208-palpitate-passable-c79bacf2036c@spud>
Message-Id: <170206026051.2485962.13304186324857333888.robh@kernel.org>
Subject: Re: [PATCH RESEND v1 2/7] dt-bindings: can: mpfs: add missing
 required clock
Date: Fri, 08 Dec 2023 12:31:00 -0600


On Fri, 08 Dec 2023 17:12:24 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The CAN controller on PolarFire SoC has an AHB peripheral clock _and_ a
> CAN bus clock. The bus clock was omitted when the binding was written,
> but is required for operation. Make up for lost time and add it.
> 
> Cautionary tale in adding bindings without having implemented a real
> user for them perhaps.
> 
> Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN controller")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml    | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml: properties:clocks: {'maxItems': 2, 'items': [{'description': 'AHB peripheral clock'}, {'description': 'CAN bus clock'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231208-palpitate-passable-c79bacf2036c@spud

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


