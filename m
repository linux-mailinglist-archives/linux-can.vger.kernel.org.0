Return-Path: <linux-can+bounces-3618-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1413BAC0314
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 05:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00B84E3C66
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 03:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E16454640;
	Thu, 22 May 2025 03:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OC8Nocn6"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9208F9DA;
	Thu, 22 May 2025 03:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885276; cv=none; b=nJnMHiEY41djGJPW2f7Olmvjr7BwX17PXRj8JeyQAXBxJTNJ6gEyu5b6y1GI+hjDxRxFSG5Nwa15h1HMYETV97/8mxzfyKMj3Je4sTXU6gnntDAuPqbE2aJ/SgUeq7miePDdmnsPNS+n1n+7MDrWzdcgON+WUklQrNmjOqsPF54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885276; c=relaxed/simple;
	bh=hpje0d0hKUxLnhR5mVdZtV+IkwxSK8YLSTLyOoJXO+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkZnLOzuGvIzMI1ACcJGDM4ZVUltkAJv4FdG4EI954J/CyVjnfstGKSLgDkvWyRmix5PTt9BVXEsOZ9sh2/oojwy8SzT3DzZ3NvM/zc43lJbvj3DbgoJJXbPfusW6h3mQnlvh/cPqDoviXxJHpHg/CCB+dr66ODjwqCeY93P/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC8Nocn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A98C4CEE4;
	Thu, 22 May 2025 03:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747885276;
	bh=hpje0d0hKUxLnhR5mVdZtV+IkwxSK8YLSTLyOoJXO+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OC8Nocn60ELqbs4vEw9ZXZq/Nte3ONo7sUTcbE38zltOjVRu3BjRWkPERlG6rCt2B
	 2zB1IR3k/voZ+mwZmUDb6RS/USRgRU8lETAytd+F+sTSyzoGsM3eczcXQy4ciBQd9E
	 OSlXuQm7IM1lyhHjLvDlMETzUYpg38QVF6fMXZjGR9qvHsvWqJhDDyB9YAh+j4kHde
	 y6fNyflCED4oDJRhFOkEMRsASRc9eECLII0GkETiUFBlhBGY18RATXCO+PW6DQzmtb
	 RBjXpFHW1EFoCotT69zaIujimTE1odzPOP2kW8EjoxAxcW1gMeGx1qO9QVpLZ1Gmr+
	 XRRRewlc5AkeQ==
Date: Wed, 21 May 2025 20:41:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH net 0/n] pull-request: can 2025-05-21
Message-ID: <20250521204114.1d131ff9@kernel.org>
In-Reply-To: <20250521082239.341080-2-mkl@pengutronix.de>
References: <20250521082239.341080-2-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 10:14:24 +0200 Marc Kleine-Budde wrote:
> Subject: [PATCH net 0/n] pull-request: can 2025-05-21

Looks like the 0/n confused patchwork and it couldn't do our build
testing. Given that we're targeting the final release I'd rather
not risk merging this without a full run thru our builds.
Could you respin? Not sure it will make tomorrow's PR but then again
I don't think anything here is super critical for 6.15 final?

Sorry for not noticing earlier.

