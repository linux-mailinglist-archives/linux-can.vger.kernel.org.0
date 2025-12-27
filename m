Return-Path: <linux-can+bounces-5946-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1615ACDFD00
	for <lists+linux-can@lfdr.de>; Sat, 27 Dec 2025 14:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92042305221A
	for <lists+linux-can@lfdr.de>; Sat, 27 Dec 2025 13:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498553126B7;
	Sat, 27 Dec 2025 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5nvDmyU"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379F625;
	Sat, 27 Dec 2025 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766841108; cv=none; b=gCSGUFom8V5dCVJBgxysJe7Y5i2N3oQdPmmc46TInkY3v6GhVXhpLXrAX6zRFhBz3koDw4retG+c1hXWsowyiUDXxu30RV98c4MBiIoC4vVDGFxbgn084scu9N+NomMifRHgIA9axi/LwsoKCLUUm+9aLJsZ6dAhl2AEw6u1bo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766841108; c=relaxed/simple;
	bh=l8V+6tckyKJtt9GcFZe8rOrfjS/QYlpduOiQ83WuxqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDNOjoK1XkBwbJhTX7RtM9sHeXjLnkDgcuxiv8uZCbf6r7UEx1hDNAu0oAw5nmJ9Jiif4ElJLChUjts+DCQmf6Ua45rghjsx6VoUARIU7wwEBQQoQF+oEak3uU4C0d9+65R9rE0AnFQM6aDUZ8jBTnyXNoSfUk0GSUk1Xh/olRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5nvDmyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12072C4CEF1;
	Sat, 27 Dec 2025 13:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766841107;
	bh=l8V+6tckyKJtt9GcFZe8rOrfjS/QYlpduOiQ83WuxqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5nvDmyUz2f/HMWDGdmnIZuffWKd+vmIk5IYqm19wJOu+VLdbdiUTOdOj/iWczbsL
	 Xkn15ZZdPxeMy1xFZDK2TrOQQmCzRUdEN7jlz7/RtxlOQVViUSUXJqREZYXZbufAIZ
	 C1hJixiwi1Ix6EPAJEXVFymAWgMXsv2BEXHWmtDu7ybdHPW+lvNxbx28OVcxNGuWna
	 MgTj70rae6fgkIl0XGHNAfnkucyG9tr5BP7hyM0noJkjn9o64JnAeA2tZFWe25mC5p
	 ef6DVN1aehTebIxVDr/sD9jPNHC5EKYF+dD52iOZxiceeBIF0eEzhmhaWZ/EeaDXH8
	 TN7ztq2E3BpaA==
Date: Sat, 27 Dec 2025 14:11:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/4] dt-bindings: can: renesas,rcar-canfd: Specify
 reset-names
Message-ID: <20251227-tacky-cordial-ostrich-263625@quoll>
References: <20251224173324.3393675-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251224173324.3393675-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251224173324.3393675-2-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Wed, Dec 24, 2025 at 05:33:21PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Specify the expected reset-names for the Renesas CAN-FD controller on
> RZ/G2L and RZ/G3E SoCs.

Instead this all mess should be fixed - you need to define all
properties in top-level and only override them with specific constraints
per variant.

Best regards,
Krzysztof


