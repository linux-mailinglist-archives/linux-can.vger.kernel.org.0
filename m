Return-Path: <linux-can+bounces-2515-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B96F9FEE08
	for <lists+linux-can@lfdr.de>; Tue, 31 Dec 2024 09:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F22A161126
	for <lists+linux-can@lfdr.de>; Tue, 31 Dec 2024 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE36818B460;
	Tue, 31 Dec 2024 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfDVkJpo"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD516BE3A;
	Tue, 31 Dec 2024 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735634578; cv=none; b=sviDbt8/UmDBOatYgFWtZTAXkMyGgUpmQTO99mGn/5gxHPej2XbjF/HK/ObIvBqTylgRJLHixllTyJwA6s861HsJ0kykkZVZFhL5wxRlOL0lu1zNRPs2D5LSBLYro0kz5m/xEfMJt+39zzY5S8a6/rvIYSiFnniSGosIwh9zgcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735634578; c=relaxed/simple;
	bh=sEVwsEUE+NBGeWQW5kfxfUmeuQ0OvQKO90sgRc/dEtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUa9WFQ/1YnroggaZJThYRNDtQRK4MYgBNneGgQqRrH2fpsqgWq04NgTvXNoEQp/1tW+kn84fci6nnqezaG53VgKLcCIem8DqEao44Ch7Z+HHOursSvl/Hi+x0rpFX/gLhRjAUGfRZmqVrywL07RTBAXjJZinD0RvF9Zc0qk+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfDVkJpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C0BC4CED6;
	Tue, 31 Dec 2024 08:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735634578;
	bh=sEVwsEUE+NBGeWQW5kfxfUmeuQ0OvQKO90sgRc/dEtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfDVkJpomnmEJ8oDf9sOP5VICaSs2vALcrI6QlE9SEAEPvdMkgIgY+6PnOmzjxmO6
	 G8VAZtJwMihHusD37VZfN/J5UbVfTJHgI7YxdGr9ctQT5jcO9ASjgC12ILNjmvjn6c
	 XpcMIavXHuGTZdhllDPRSv0vke5hOnSzZX5HiZ/U2JJVHbuEEKaxXlkdZYlVtposNJ
	 fLlBWH/0xkAeoc6PdQ1KHnwNIcDQlB+fCXrSZvHV7SbaKkFV/adjRwTqbObYBCNm5Z
	 BrvG0SAYr65cRz0g/e5AMvGZ6uHwDqv0zcnDY6HAw5Odkew+Uubi0LesI3mPF6yRtR
	 brPb4wksCLDVA==
Date: Tue, 31 Dec 2024 09:42:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring <robh@kernel.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-can@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: can: st,stm32-bxcan: fix st,gcan property
 type
Message-ID: <mqkkf4vgd25mq3xvial2unlyumtsbrei7ajkouvrsvkn7pc66y@j5do2qzlgysc>
References: <20241228150043.3926696-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241228150043.3926696-1-dario.binacchi@amarulasolutions.com>

On Sat, Dec 28, 2024 at 04:00:30PM +0100, Dario Binacchi wrote:
> The SRAM memory shared pointed to by the st,gcan property is unique, so
> we don't need an array of phandles.
> 

You should mention also that Linux implementation does not expect any
argument.

> Fixes: e43250c0ac81 ("dt-bindings: net: can: add STM32 bxcan DT bindings")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


