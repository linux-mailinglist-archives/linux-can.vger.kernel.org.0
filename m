Return-Path: <linux-can+bounces-2786-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5764DA2F513
	for <lists+linux-can@lfdr.de>; Mon, 10 Feb 2025 18:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E561188A246
	for <lists+linux-can@lfdr.de>; Mon, 10 Feb 2025 17:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F7F257421;
	Mon, 10 Feb 2025 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH6Zbwwo"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD82500B4;
	Mon, 10 Feb 2025 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208078; cv=none; b=ABIbesPwF07x3aIUSSJkxZccPZN0Mn+j/jkTGhbJQlAVGs1DyYYGXJlyM7bn50cxT5MMB+rZBdFYSeqeSXTBTzY7A4nHAY7TSIPuda8KiQlqKnOR7aF+6TO8pUqorHKV07Uw+2KjmAbyd6Iw9CeXpqmYZi67UH6de7Cw2nUxSlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208078; c=relaxed/simple;
	bh=4dfjPhPpwR3tUG3LV/LuaU/Rp/qJ4AK81d8QI0QBwJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HOS8iI99Xy9lhoxkF0Pq+f4ui8hokul23xVtG1YcqpGYtDZmJ6VX9E0yut7NtVj7Xls2RnnmFaCsWrApTkhXEpuB8A3nwInL7bFAe6/A8w0ynAYzpvv5AtYxFvf0HLqqjbENLdWAuvuhi6GzHzAk4ItCiE5zqJKQQyJ5fcv0PZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH6Zbwwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEC6C4CEE5;
	Mon, 10 Feb 2025 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739208078;
	bh=4dfjPhPpwR3tUG3LV/LuaU/Rp/qJ4AK81d8QI0QBwJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DH6Zbwwo9rIA6asG82bQ7YALq4p8NbT/a4sRQZnAM5sGqJFAs9cpiJ9i1BDG1ah7k
	 ufr1tXUPnGsN4o7OTiiVo07KkyhDZveBR5ASw9yENdACh9RTx7z0PFtGldTgCUmr1d
	 vmRUAWg6cA3w3NaeyAnmDow48R8J3shmM1iIDV8YfhzkAx72kNMZGH0E8sUk9Jvsn+
	 StF2YO8/s5pgKmJwQJuT7eujtnaERrzknEMeCbolJlE8Uu/Us8Z89xXQZMTu9h7a7V
	 L5g6arvl26eL37/gyiQKfi8hSLy8cc1WxFBlRY0ldIMmCwt3R7ZrofVtvfDq6FRx0A
	 0ixmpZRSbGDTA==
From: Vinod Koul <vkoul@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250203185421.3383805-2-robh@kernel.org>
References: <20250203185421.3383805-2-robh@kernel.org>
Subject: Re: [PATCH] phy: can-transceiver: Drop unnecessary "mux-states"
 property presence check
Message-Id: <173920807568.103786.8838731795889395787.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 22:51:15 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 03 Feb 2025 12:54:21 -0600, Rob Herring (Arm) wrote:
> It doesn't matter whether "mux-states" is not present or there is some
> other issue parsing it causing an error. Drop the presence check and
> rework the error handling to ignore anything other than deferred probe.
> 
> 

Applied, thanks!

[1/1] phy: can-transceiver: Drop unnecessary "mux-states" property presence check
      commit: d02dfd4ceb2e9f34caaaaf87105267e2f722f443

Best regards,
-- 
~Vinod



