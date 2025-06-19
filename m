Return-Path: <linux-can+bounces-3874-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB52FAE08F4
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 16:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EC61BC5DAC
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5069E2264C1;
	Thu, 19 Jun 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyP3FWQG"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249B11AA782;
	Thu, 19 Jun 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344112; cv=none; b=W6GagOMtE4DWyO1XeEU6w4YbsS4v5LfGv1Fvg6aEE9Ay7Tu1ZWp44dZ6JdUXuH97rnIkdBWX21MO8Ip19TtCY3YxKhyl0u3kseTCVdQ1/Fv15ClB15FnlCmRo5sQ3Hv+EmWSRecNS6cbThIHauI1KpphBF26eGkM7z9jiyNszYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344112; c=relaxed/simple;
	bh=GpHmjHuZACLqv3N0cwcSZsOLDoCubWR8H68gS49+Ew8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxVOdlVFiVmbvliqRT55AclaQgJ/1ax+ZGv0s/Dww3k+RKlCjiVonHZ3LGmqz6JsHrgVdaHq4v64Lps6P0t8paXlb9RkW51QG69qPpmpxoHXCUW0Lz2w7QQpMozHbj1mfByQ8OA4o2C7AtPIvrZCtWoR0mfSXbGhYvbHhCxnUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyP3FWQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510D3C4CEEF;
	Thu, 19 Jun 2025 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750344111;
	bh=GpHmjHuZACLqv3N0cwcSZsOLDoCubWR8H68gS49+Ew8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EyP3FWQGYiEuRKKF3KpkMJHKAFnX4R+0EfA4OCD52hjwweASZGO6wxOxRqK5aaM8v
	 47F0VXdkrvQaqc0AeQLmgNL2y02Ka5+5fAxVqKEO1ktT7wwvCW7fCdlQLaZ1aoOhvD
	 3GIcNiKu7u/2lNQhl6sBbtlHygIKZsuBPU9t/OihBBQZJaHXTJe8rMzbr2jy2T9q+D
	 a4NeuGkG2rglFJvI4gosfvw5ct9MdqL063TQOCAuRe5LSuvYkXD1szIaF9MoDpw5Kz
	 ciulQMMcIOrd6aq0Os8cZUYKQKeEcJhG0HU1D+5IsHsp4GiGFz2QdDSG+pnvskPdYP
	 RgxEQEm3U9gKw==
Date: Thu, 19 Jun 2025 07:41:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Biju Das
 <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Marc
 Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] can: rcar_canfd: Describe channel-specific FD registers
 using C struct
Message-ID: <20250619074150.31e39212@kernel.org>
In-Reply-To: <88b0892f-5994-4b7a-9de3-eab39075acaa@wanadoo.fr>
References: <292b75b3bc8dd95f805f0223f606737071c8cf86.1750327217.git.geert+renesas@glider.be>
	<88b0892f-5994-4b7a-9de3-eab39075acaa@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 20:12:41 +0900 Vincent Mailhol wrote:
> @Jakub, OK for me if you want to directly pick this patch without going through
> the linux-can tree.

Ah, missed this before replying to the other thread.

We'll take it direct then, thank you!

