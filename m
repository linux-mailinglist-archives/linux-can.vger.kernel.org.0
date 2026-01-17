Return-Path: <linux-can+bounces-6208-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8ED39011
	for <lists+linux-can@lfdr.de>; Sat, 17 Jan 2026 18:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 095913010297
	for <lists+linux-can@lfdr.de>; Sat, 17 Jan 2026 17:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B6A2882BE;
	Sat, 17 Jan 2026 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+Pl24zG"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC255287263;
	Sat, 17 Jan 2026 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768671004; cv=none; b=GFsekewJAym9tl5LbAnZzWQpXE42+/Xt0T2pPVApHLWN50u41+NYm0wKaoIly+i5DEvTXOBOY9PGKgzEfMIACcYQRF4vGzYF79+xEcGAY3E2i4uuTYk+5t3EKSG1jRXgTprBxFm3PUOs+uDk0qMtM83kkUBRcJYSKQ+075S4iZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768671004; c=relaxed/simple;
	bh=+GAQveDeVlhR8PfP5XApmWAfz+bMQjBhWI7CRK4gsA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sj+yhXpISHgf9hi+mK0Khr+qabYP6Ta9Wk7lr65eSSIz706k1xx45gYhGdsKVd6eGjLCmg0z9EfOuVFlRuvrUH3VlIdDkOjHCA0T3zIK23ZKgvqHPJYuwfechxgTNdPMPmMXSYrxkFO4HP0C1EJRzMBVqyRRoDHBqzOQzAizKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+Pl24zG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFAEC4CEF7;
	Sat, 17 Jan 2026 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768671002;
	bh=+GAQveDeVlhR8PfP5XApmWAfz+bMQjBhWI7CRK4gsA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q+Pl24zG41YnRexal3VDJAzA7F57GodKuRW7tjxK9ubXYAYTqCH1mBtig7YvTBoSC
	 byyDFaFUZ5w4eZL9OPko1ZDL+PirpOXXRY8oNqvhEkvNKb+pNI+/H7cYw7kNhBwEsE
	 DoQyjDl5zyGxWsSWm8R3SRHepeXvHeGcnJmnMOmY45XZYXTpI08BaD1YePQy/WpFzv
	 cF/L5oDyT1hT2rpYt1pJb4lDEoDG2AYt5V/Q+xdOauQ9MwcBLgih+Z+Qfav5QGnNlJ
	 ZFXhZe4NM7+ZP9RaK+4rTJo6oedHJVY6P5Ly5VF545baSeN3QIqNtZZND1XHQnpBet
	 hPtSK2tS81S5A==
Date: Sat, 17 Jan 2026 09:30:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH net 0/4] pull-request: can 2026-01-15
Message-ID: <20260117093001.48949bf6@kernel.org>
In-Reply-To: <20260116-romantic-hog-of-saturation-743692-mkl@pengutronix.de>
References: <20260115090603.1124860-1-mkl@pengutronix.de>
	<20260115185110.6c4de645@kernel.org>
	<20260116-romantic-hog-of-saturation-743692-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jan 2026 18:03:39 +0100 Marc Kleine-Budde wrote:
> On 15.01.2026 18:51:10, Jakub Kicinski wrote:
> > Hi Marc!
> >
> > Was the AI wrong here
> > https://lore.kernel.org/all/20260110223836.3890248-1-kuba@kernel.org/
> > or that fix is still in the works?  
> 
> AI was correct, the proposed fix was correct. The patch will be included
> in my next PR:
> 
> | https://lore.kernel.org/all/20260116-can_usb-fix-reanchor-v1-1-9d74e7289225@pengutronix.de/

Excellent, thank you!

