Return-Path: <linux-can+bounces-2967-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2685A46465
	for <lists+linux-can@lfdr.de>; Wed, 26 Feb 2025 16:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7D43A95E7
	for <lists+linux-can@lfdr.de>; Wed, 26 Feb 2025 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45626223329;
	Wed, 26 Feb 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj6ZWkER"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EA221F02;
	Wed, 26 Feb 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583051; cv=none; b=HqgRk2cUGjrHnctMDL20o5SjJdFpRisAmbyJXmD0P+1qCaaOMihwNW7Q0HiSTZuw38736azPxMVkTrQOhjMRS+g13IOXb5P5+pAD/wDCzj9FSGKvf9FxI5l7x9Quup5JAHCReo6CJXt6FoiIIRNogVHLGbrh04yh2iXZKFLgyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583051; c=relaxed/simple;
	bh=HLEdz73D00w88HXZZ+oaxL6U9rSubm/+lhAnl0faZsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9TEGNS6nbDNn2A26v55XE+TzLWFhh3PjJ9daWvN96ysSbRt1qA78OmqGgiC/mLWTQ7SZHldtIcauFwlHkZhUPsUZP+yXdEMlmk/1SB/wSweoU8RZ37IMzGUfcfN5Xb65ERh+f1irtDhBORgdUs8XU2N8iN4j0IyIgX95RrOi+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj6ZWkER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7FEC4CED6;
	Wed, 26 Feb 2025 15:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740583050;
	bh=HLEdz73D00w88HXZZ+oaxL6U9rSubm/+lhAnl0faZsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oj6ZWkERseJplSm/nJBGRSrsQQY0/HA+NQpu0CIfdeCABeqJlAC41cgQ1LHM+yjyl
	 odSedzjqMwEbGiaiWTDuClG706alxMITQrsm/TCaw8/vBX3YMjRHpA1/8nKLW1xjCx
	 WdWU/1cK9JiDJaydClsYN6aj/kCVbOkyZzJ668ImosOZThJUyhOgG+an+s40PNEzRG
	 kSHuMJDA5JA8dyXFec8cZfgwjvHv6Qw0a1hMSilOQan1uER6jX7MXhKOwi+1l+ebql
	 Q17jp9rqruGcP+56FMNDU8QbiEFvp8K6JDWKQ4yY4KMfDpdm7Rc+vecjjSH/lXOcB+
	 4nfZOegQA/aUA==
Date: Wed, 26 Feb 2025 09:17:28 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.au@gmail.com>, linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 02/11] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3E support
Message-ID: <174058304824.2447291.564139557044220486.robh@kernel.org>
References: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
 <20250225154058.59116-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225154058.59116-3-biju.das.jz@bp.renesas.com>


On Tue, 25 Feb 2025 15:40:41 +0000, Biju Das wrote:
> Document support for the CAN-FD Interface on the RZ/G3E (R9A09G047) SoC,
> which supports up to six channels.
> 
> The CAN-FD module on RZ/G3E is very similar to the one on both R-Car V4H
> and RZ/G2L, but differs in some hardware parameters:
>  * No external clock, but instead has ram clock.
>  * Support up to 6 channels.
>  * 20 interrupts.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Replaced maxItems->minItems: 20 for RZ/G3E interrupt,s as the list has 20
>    elements and for existing platforms dropped minItems and keep maxItems: 8.
> v1->v2:
>  * No change.
> ---
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 69 +++++++++++++++++--
>  1 file changed, 62 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


