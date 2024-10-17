Return-Path: <linux-can+bounces-1717-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB079A2708
	for <lists+linux-can@lfdr.de>; Thu, 17 Oct 2024 17:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5961C2341F
	for <lists+linux-can@lfdr.de>; Thu, 17 Oct 2024 15:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171201E0DAC;
	Thu, 17 Oct 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1235NFU"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C01E0DA6;
	Thu, 17 Oct 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179389; cv=none; b=kzvWprzBbMN3A7TkgbwiTYGXEkBISiE97V84YGQOzkQuFtk15xGdQe3xZQzjA58zj9w6CG+BeDOYaYOXMwk3MDJ8gOot4rUq/9rlZot8dmm0nFeQP2PaR9qJB0F0bNDaWYbRbneedApazpqKHbXeKI2iXLJULo0mgjYWKm86twE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179389; c=relaxed/simple;
	bh=yqiocebZ9SEFK7KVOaQ0TDPRPwoojCOZC8oUaANHbI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tlPiZI3uOUuLix6GkS3hJo1Xth5tACCFn63j6hWUtbUC3LgF/9hf+wzYGuZkw6GN2escDWgzjxNohm9h2y+zmezyfY/MeHzJqTJG04XYTaxWCj8Brj3bjwILZu3wNzlcuSBzfF4eDiXVMUYNnlNq9ies/ckKy59ZojiDnnUXSLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1235NFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7371C4CEC3;
	Thu, 17 Oct 2024 15:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179388;
	bh=yqiocebZ9SEFK7KVOaQ0TDPRPwoojCOZC8oUaANHbI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c1235NFURWrYSC6PrUzE+BSsOO8oX7OsAMv5syVgxuTW6QQgsHQfixXLIpCcAPqp7
	 8EVRraUYv7EfVk6Jvef+WG+F5uPUD6xCDPij3Hfi1lJEzN32kT4lmIPIPVK6sU/U6v
	 TjP8Tn/7sGJ0z7u9BfPwu9EuCsbT1K+Igzj8XF+z0p+ZvdWhj4sS5RO8T3PWBWdfb8
	 myBiQAL4ZmMCpjbs3YZ9yBHYl0B/YrjCIzpXGFN0M8MJr1mEH+xzZxW2RWBD08qakz
	 ijVaRo7u5cXuhw7E8ClIpritUUE9ZxgkyMaAz+1lA/CraGO6y6uUS1IkC8LxK2BPET
	 WsW0Q2nVJzrHA==
From: Vinod Koul <vkoul@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Ilya Orazov <ilordash02@gmail.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20240915141831.2809208-1-ilordash02@gmail.com>
References: <20240915141831.2809208-1-ilordash02@gmail.com>
Subject: Re: [RESEND PATCH v4 0/1] dt-bindings: phy: ti,tcan104x-can:
 Document Microchip ATA6561
Message-Id: <172917938558.288841.9225642132798904905.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 21:06:25 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 15 Sep 2024 17:18:30 +0300, Ilya Orazov wrote:
> I wanted to kindly remind you about my patch submission. Just to clarify,
> my patch doesn't introduce a new driver. Compatible fields from
> ti,tcan104x-can.yaml is used by the phy-can-transceiver.c driver, which is
> already part of the kernel. There was an issue with my previous attempt to
> resend this patch. Please ignore it.
> 
> Could you please review it when you have a chance?
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
      commit: 26ac85e3adb4775df42d94b310276b06c0898d3d

Best regards,
-- 
~Vinod



