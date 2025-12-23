Return-Path: <linux-can+bounces-5922-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A95CDA28E
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 18:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 182663045910
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1734B19F;
	Tue, 23 Dec 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBanMw5C"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A19634888A;
	Tue, 23 Dec 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511900; cv=none; b=V/6tqkAWAltZkHwd0JoKll31uAhvjDyISNJIshR/wEHZo5R3V0QN5Ac+O8eSi9pnrQLvv7QU1a/hLcojF+BUHPZnOEdPG447FmCRUnrv6w0mm5jFA+O6SUSQ5oBDw04dcEHz3zvsnLJz+3CkF/+lTiGA/7NpmtvFCZN7Jn/iLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511900; c=relaxed/simple;
	bh=7UcJoh+9uo128/NiZFzblIxses8/TnRGhjyIQQ/1NLk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Elu3tp3FSeGgk3YmKyVl5Ygo+8FA2kmRPM0U1ssO2lHN+Ksjs36t4DckML6eF5ySVe2VWQR40dg1SRWcf0w5cOXFk9J3tbNvf8vx7tUA2h+13LW4yBWk1iuyqRNmYmMGuKzKl2IE4lHHPJtC4NXoFdaQ0SJJxnjAunv8KGN2jeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBanMw5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2E9C116B1;
	Tue, 23 Dec 2025 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766511900;
	bh=7UcJoh+9uo128/NiZFzblIxses8/TnRGhjyIQQ/1NLk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZBanMw5CTV2hTrz20Sz2zEqujCGmBDhmW9ROrWfnaochVVmDu1wtLhzSFeeOm/wq9
	 0MN+Tzxg9Bodh7VEhhA9FGMNpVLScfbRyN69yQrDqYdCCbDKTKqTjrevUdW81FqL/e
	 2ItU4Stak97SW12gJFIRYo2cgV9nk1GhRzC0+HJZ7cMY5isl3I/66qi3n31tNeBG1W
	 vQs3cIAEdoGNr1rOv3nowsXrusJI4Xm9XPtbKCZlh1kte51bth9KUUThZilCYKvwwF
	 P7Lz2z4WyZRH9gtDW+4QTv7aFZedVs8B6lRycXmM71bPiDFwLweHRpjrJ90G3ar/wg
	 FAmSkpVTHw62w==
From: Vinod Koul <vkoul@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Frank Li <Frank.li@nxp.com>, Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251209162119.2038313-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251209162119.2038313-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] dt-bindings: phy: ti,tcan104x-can: Document TI
 TCAN1046
Message-Id: <176651189540.759340.9131667922285339029.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 23:14:55 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 09 Dec 2025 16:21:19 +0000, Prabhakar wrote:
> Document the TI TCAN1046 automotive CAN transceiver. The TCAN1046 is a
> dual high-speed CAN transceiver with sleep-mode support and no EN pin,
> mirroring the behaviour of the NXP TJA1048, which also provides dual
> channels and STB1/2 sleep-control lines.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: ti,tcan104x-can: Document TI TCAN1046
      commit: 5442f9fd8814932e42602670bd013fcbc10a6906

Best regards,
-- 
~Vinod



