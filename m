Return-Path: <linux-can+bounces-6099-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C62D0D0DE89
	for <lists+linux-can@lfdr.de>; Sat, 10 Jan 2026 23:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56D0D3016FB6
	for <lists+linux-can@lfdr.de>; Sat, 10 Jan 2026 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B57287508;
	Sat, 10 Jan 2026 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foFTQuee"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5282652B0;
	Sat, 10 Jan 2026 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768084713; cv=none; b=b0vnDt4FcWLvyTBdwm9KFAfKS/3ISDElYRAgsiSG6M7fIZEt6bqQn2sSwVQ8xvDOspoYqzKtOMFmmyzn9m8r+1mr3sr2nNjqvHgFsrIVVvbCET9hJFsaAWveZ03yjAvFNPBAO8k+lmvV7jfyVQp5WmVMw132xUKjn7kpmf1jx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768084713; c=relaxed/simple;
	bh=HFCOzfQU9i3u2PSh80klIZgvaDOX42dhVBkG3Q1XfYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3rLXIvO9uVmcl5AzKoJ5mJyiADZDxI1hk6a+RShBS9ZFvMwWtB3YkI+YDEeNm1Rrg07DSbL+CbMM8b96YwHJkY7fJw6Yrnz0FMHyxRlDT+ogA8kd7GwwCJ+zDKw+2HLLcMZhSO6eAHYAvhCrBp2KSt5qAA3VTeJPoBeJikhxzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foFTQuee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0601C4CEF1;
	Sat, 10 Jan 2026 22:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768084712;
	bh=HFCOzfQU9i3u2PSh80klIZgvaDOX42dhVBkG3Q1XfYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=foFTQuee6WryErzALYP5/OfyPj0fEzkABEreFP2G4pMduZUOsikzDJARxsdTBL3gK
	 Lj90o0FLk5thX8SyIePW/CuWTlE4p1DWpjzVZTt+Hl76zxRaNfiSWl+anQNuByNjg1
	 HFfyRGDFCZ6dv4tR9FXtQnkMFDv/JmOZmmHQmAn6O5brgpGYNPM1J+WOWvGgZO0dXv
	 sQtnpldXBoMQrUi6nTxRZWH2+YIcB3kTmhZPMV7kSfBOCK4T+Cn2BdbKr+leGMMrTh
	 xoXtQnuLTFBMWRUL7uw0FKoeNxNwg1WmYP1riO3jMEsyGr3DP4eiEpGBfzrSDc/Bi+
	 tElQfQG0enFuw==
Date: Sat, 10 Jan 2026 14:38:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH net 0/3] pull-request: can 2026-01-09
Message-ID: <20260110143831.64d94718@kernel.org>
In-Reply-To: <20260109135311.576033-1-mkl@pengutronix.de>
References: <20260109135311.576033-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Jan 2026 14:46:09 +0100 Marc Kleine-Budde wrote:
> Marc Kleine-Budde (1):
>       can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak

Our AI code reviewer found an issue in this one, doesn't seem like 
a blocker and I think you don't rebase your tree anyway so no point
delaying the pull. Please follow up as necessary.

