Return-Path: <linux-can+bounces-1962-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38CE9C44A4
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 19:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D55B2270A
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70D51A7270;
	Mon, 11 Nov 2024 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx5d984v"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE942B9A9;
	Mon, 11 Nov 2024 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348613; cv=none; b=uA883C0uR7o+MEf4v6dSQWQDEMkV9vW8y0S9Qdie3GNTeAgf/DvG7WehAMTsNW9dIxs5ZfTYUvHyILD7AlMxRdqm/Un0FJ8AdgIHU2lQCPEOW1hh3SNx3EESJyajMGPVgJJqaFMw3RrCCvRKWhdHTmAKgMAQQ7w6AV9fewLK5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348613; c=relaxed/simple;
	bh=7vlsVM41rkfd8n8v64r+8xQCmi8NiyCLz7rtqbFRmEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxvf9dMpvOpoMf+GkzKMOk7YDPXtUx0b6VSnsce+eo+PnCbfRaoNACc4tdrIvkoJ+ezjGdjvAageHykMmZ7g7gaFnvcCVBaOhSa2fJuUKP6Ne6NsZfFqhTQJzIwGrKEriNMUv+N5gqfjAqHMqOJ1K/Ta7KzxTDgsf/fVr1N+Csg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx5d984v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF193C4CECF;
	Mon, 11 Nov 2024 18:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731348613;
	bh=7vlsVM41rkfd8n8v64r+8xQCmi8NiyCLz7rtqbFRmEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fx5d984v6XlO4AhvzeG0ALATi8GlzTvluAwtV3CQgF5XX67RogJwUO7xvy0KmcVJy
	 NvNSJxU4EinIiuOpn7dCewLmbQeW7GTs68Y44M6VMfXwH7R+J/+X7FteXpLpFh3ekH
	 t/BJPa/MRxoBnly1zNYQt47jJggq8TJIavxJaExzw3nXea3rUcqONLPpLk4/mc1sYO
	 pi3Xj82Pj17XXxQuFyy1yCqc8Qwvz2fkgalbVag3qC+S1Vg71NzOa477mAvon1Gd0j
	 mHRbfv8SlDgY/0HXEDLB44dcoRntRsnM2fSEn7wzsc/6qvBKuM1LRI1hy3FFHqqDhE
	 zfVhAA5LzDxtw==
Date: Mon, 11 Nov 2024 10:10:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
Message-ID: <20241111101011.30e04701@kernel.org>
In-Reply-To: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 09:54:48 +0100 Sean Nyekjaer wrote:
> This series adds support for setting the nWKRQ voltage.

There is no need to CC netdev@ on pure drivers/net/can changes.
Since these changes are not tagged in any way I have to manually
go and drop all of them from our patchwork.

