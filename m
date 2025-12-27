Return-Path: <linux-can+bounces-5945-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6F5CDFBA6
	for <lists+linux-can@lfdr.de>; Sat, 27 Dec 2025 13:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7285D301EFC0
	for <lists+linux-can@lfdr.de>; Sat, 27 Dec 2025 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81456339856;
	Sat, 27 Dec 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdX+lrnS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C682D23A5;
	Sat, 27 Dec 2025 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766838675; cv=none; b=HjzHbAEGoP9fxozVSNayz++zq/y+npvTzGJf9IvE2swLPggzquaAZ4y0MZXhnfATdg4ShvKCOj59Rc+ppTu67912aPWPeZRGPNOjGj2TtfT3+NfHZZQP4l1ba3hXH3vn37iTHa5vUwZfc3luXdKZhyX28CoaHQvX2uFUuvuYvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766838675; c=relaxed/simple;
	bh=blzpBhq9e/2lmcYxWv8XlMw+KPraYKJ3bELesYBQ1Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOUN6bA9oksmrf1/+zOLMVtpf1WB8JplkAi/p1pPCvnPT+p0+qp7BvLxGHqJz+nBgVjzG19aYcR7FsGAooPdLTPMNIz9CEmWWnRL5eTLots5otBjyKv/Dv4NOmfKPjEaA44Z22o6YVicaDzXgJUtfxocGGeEJ2AkTVkKeMYRkdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdX+lrnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A633C4CEF1;
	Sat, 27 Dec 2025 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766838673;
	bh=blzpBhq9e/2lmcYxWv8XlMw+KPraYKJ3bELesYBQ1Pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdX+lrnSsbOWXg91P/7y8JXRH7FgvCxGp6gOP4O2+Heszi98rAkSoCXd0gaVsBpDj
	 kAd3lmGmcdobguPrt+ZahAdBnBwUlepzzH6QoI+rKC12to/FgjZAcpchahpQRj1C9c
	 gWkf44IdeG1axFv8+Vu46ZIMGA4Ua+izS/QcQR8wgUqDWVjxTG0dP0hq8/ukyVoPk7
	 NpKnwX3prcqRG02DUI/tbAosGGfmKSaLvGaE7PmQbwnyof2PIBxNsR66zvFFBE4sWn
	 SYs9KvD1ToUc4QePYOvXMone+m5sTRGhTpwEwrvco8dKI7GU0iHq5CshfMmL20kflF
	 HktKbbHCbf/Sw==
Date: Sat, 27 Dec 2025 13:31:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mkl@pengutronix.de, mailhol@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
	Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: Add vendor prefix for Frontgrade
 Gaisler AB
Message-ID: <20251227-camouflaged-malkoha-of-economy-d44a2f@quoll>
References: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
 <20251223105604.12675-2-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251223105604.12675-2-arun.muthusamy@gaisler.com>

On Tue, Dec 23, 2025 at 11:55:55AM +0100, Arun Muthusamy wrote:
> From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
> 
> Frontgrade Gaisler AB provides IP cores and supporting development tools
> for embedded processors based on the SPARC and RISC-V architectures.
> Some essential products are the LEON and NOEL synthesizable processor
> models together with a complete development environment and a library of
> IP cores (GRLIB).
> 
> The company specializes in digital hardware design (ASIC/FPGA) for both
> commercial and aerospace applications.
> 
> Web site: https://www.gaisler.com/
> 
> Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


