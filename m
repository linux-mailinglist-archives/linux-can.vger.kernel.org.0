Return-Path: <linux-can+bounces-1633-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D62E199A6AF
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 16:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F09E1F242A3
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 14:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9AB83CDB;
	Fri, 11 Oct 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKvQKtTI"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88D381720;
	Fri, 11 Oct 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657844; cv=none; b=KmMK62Q2scGoqN/ngwy834qlI/vv3+Bj4TyFjUzZnQ09GbovQGW+z9cc6ZlcnVWlguR19ror/ljkTJI64fyu8v2vXOwnoKxZRoW1SQjW521yfa/ekdKxN8U2Ja3qME5LixGKwszS/K2552RDFX2fe+yRs/dHB5G3fvRdiG3PM0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657844; c=relaxed/simple;
	bh=+Bfc/h3wXzcXYp8P74NjzQObBuibQL+a4Ik7JWONOAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KToLxYoowU0/XlZgf38+PBZgHqX8kAiKBHvyWXtszNhrjlNzZo+NmXXpW3tOgjtJrITIiTNq2m1IlyKTnFpn3d9Hej52yyfGavubrirm4fzlnyTwk4sWLDIuKWek1aqdjsCeUKWZd2VD41G0NTCrVvH+KknuLrFI/Jw9t9BPmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKvQKtTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32759C4CEC3;
	Fri, 11 Oct 2024 14:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728657844;
	bh=+Bfc/h3wXzcXYp8P74NjzQObBuibQL+a4Ik7JWONOAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nKvQKtTIBQsxlW32D6uK36R6aMcJDyUVKKRlekAMWnC5B0jAp5cWkFqvU8XqczAKF
	 EHYUA0pPC+v5WsKvPNZZxRqecUY8/j8TGwZAv/3/CzQDcaijOA6BOZSK0WfyfbIZN8
	 MhSv2hcXzXC09FxBeYf+Hl+X1oBHd/+nPfw6t2207bdUVooXrsnu2M45epv6zlKwgO
	 s2CM/nv644PM9UWIROVpvfjIB3qCikVAcJo/C6e2qf/KfgGkfYgazPL7k6cKSre7QM
	 1p/M2KHiGX1MfzXXSlarUWDDaZsxbzkXcKj447VZGzrki9EsQSq7jn/wA83atFry6H
	 yhG7mjvu+/kSQ==
Date: Fri, 11 Oct 2024 16:44:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3 2/9] dt-bindings: can: m_can: Add vio-supply
Message-ID: <bbz7h4vfbzusvdqtbfzxo5xdoddqp5nonoywvbrhtwukjus3pp@5amm37u22ehh>
References: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
 <20241011-topic-mcan-wakeup-source-v6-12-v3-2-9752c714ad12@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011-topic-mcan-wakeup-source-v6-12-v3-2-9752c714ad12@baylibre.com>

On Fri, Oct 11, 2024 at 03:16:39PM +0200, Markus Schneider-Pargmann wrote:
> The m_can unit can be integrated in different ways. For AM62 the unit is
> integrated in different parts of the system (MCU or Main domain) and can
> be powered by different external power sources. For examle on am62-lp-sk
> mcu_mcan0 and mcu_mcan1 are powered through VDDSHV_CANUART by an
> external regulator. To be able to describe these relationships, add a
> vio-supply property to this binding.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index 0c1f9fa7371897d45539ead49c9d290fb4966f30..e35cabce92c658c1b548cbac0940e16f7c2504ee 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -140,6 +140,10 @@ properties:
>  
>    wakeup-source: true
>  
> +  vio-supply:
> +    description: |

If there is going to be new version: drop |


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


