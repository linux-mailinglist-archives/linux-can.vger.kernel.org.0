Return-Path: <linux-can+bounces-87-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A864780AEEA
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 22:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6CA3B20B33
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 21:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7A75788C;
	Fri,  8 Dec 2023 21:42:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E13198A;
	Fri,  8 Dec 2023 13:42:33 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d9dc789f23so1284253a34.3;
        Fri, 08 Dec 2023 13:42:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702071753; x=1702676553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAfN68Sm3Ma2VnLB4uj+2M8nBwQbTqyO/LCdJPBLHVk=;
        b=a4w4GlhL/az785aU+qrXETD6+OL6D6GbWeWjCj7v9QN5fAj60HBfgzgrlk9BZ1pVnx
         5HFPqXsa5tUnpeTzyILT8WnfA5dQR5PnI60DVH5ovcUDok6LmvO8013aM/9vfSqdx30T
         upql/dIxXs4gAxJbRZrT9BioimMOt4DFAYtHqFvR32nvH61folMpxxH6PWp0igUsFcrh
         iXj2CR/UeOhVOnmPxRRCrsc1MDXqXPs0biM3IYNHYw1OScBFV/OdLeuSo0+FZVBqp63e
         sp+NyXNmjbgh7GdxQTqTGILnhF4eIC7spEE5gUj4XuWCQCh6KfyWC7VgxSHRw+zHbDu0
         V9fw==
X-Gm-Message-State: AOJu0Yz0vlOdLJFUGFrmD3ecGgowEbI2fe6r1PaDms9tM/kuwnsszcVf
	krmv6d3sIaixsozScG7Lcg==
X-Google-Smtp-Source: AGHT+IEmwxuggTo2ju30Ucv6bYuJd0p/9ogjLzvbfH0HbqDKNhshngTzZpOVDv288xxzAQmTakEB7Q==
X-Received: by 2002:a05:6870:1b0f:b0:1fb:75a:c415 with SMTP id hl15-20020a0568701b0f00b001fb075ac415mr846554oab.62.1702071752839;
        Fri, 08 Dec 2023 13:42:32 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id gb8-20020a056870670800b001fb4aaf261csm607175oab.32.2023.12.08.13.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:42:32 -0800 (PST)
Received: (nullmailer pid 2852367 invoked by uid 1000);
	Fri, 08 Dec 2023 21:42:30 -0000
Date: Fri, 8 Dec 2023 15:42:30 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, Daire McNamara <daire.mcnamara@microchip.com>, Wolfgang Grandegger <wg@grandegger.com>, Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org, Eric Dumazet <edumazet@google.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RESEND v1 2/7] dt-bindings: can: mpfs: add missing
 required clock
Message-ID: <20231208214230.GA2850699-robh@kernel.org>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
 <20231208-palpitate-passable-c79bacf2036c@spud>
 <170206026051.2485962.13304186324857333888.robh@kernel.org>
 <20231208-contusion-professed-3b2235f7d3df@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208-contusion-professed-3b2235f7d3df@spud>

On Fri, Dec 08, 2023 at 07:25:39PM +0000, Conor Dooley wrote:
> On Fri, Dec 08, 2023 at 12:31:00PM -0600, Rob Herring wrote:
> > 
> > On Fri, 08 Dec 2023 17:12:24 +0000, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > > 
> > > The CAN controller on PolarFire SoC has an AHB peripheral clock _and_ a
> > > CAN bus clock. The bus clock was omitted when the binding was written,
> > > but is required for operation. Make up for lost time and add it.
> > > 
> > > Cautionary tale in adding bindings without having implemented a real
> > > user for them perhaps.
> > > 
> > > Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN controller")
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml    | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml: properties:clocks: {'maxItems': 2, 'items': [{'description': 'AHB peripheral clock'}, {'description': 'CAN bus clock'}]} should not be valid under {'required': ['maxItems']}
> > 	hint: "maxItems" is not needed with an "items" list
> > 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> 
> 
> Oh dear, me of all people.

Happens to the best of us. :)

