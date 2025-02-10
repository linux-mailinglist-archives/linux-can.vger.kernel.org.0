Return-Path: <linux-can+bounces-2787-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0602A2F5FE
	for <lists+linux-can@lfdr.de>; Mon, 10 Feb 2025 18:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196061882FB8
	for <lists+linux-can@lfdr.de>; Mon, 10 Feb 2025 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A6525B683;
	Mon, 10 Feb 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="I9JvbYmA"
X-Original-To: linux-can@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4CA25B66B;
	Mon, 10 Feb 2025 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210110; cv=none; b=VnBl/d0yGD4pj4YSmJNKvrW2GN3qjjPaa7TelC8tNVpz0xYtEACN6xXL+25WBh/xQgwECjrQHkqTscOa3elgsQxe+hbsz7k/1NBk7lN6NgdmiykMZ083QyAD9eQ6rleJrwCZyTaJBPpSyfYyAU7/VENtGLpfmVd3RigpJa3mdKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210110; c=relaxed/simple;
	bh=Ft93EquVMB68txAY9N3rvoy093S40GPOtRTZQhi5Is0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZusQtmAL+E2mGd5cUvlZW+5zljgiBKWQcfprGJ5nRw4SIXHCbbe5yavgy1/mSwjHzCWYJQeCQJH6RklwsHW0z6NTVeiFeAEWkJH1g+sB6NgeGvRwwJi6UaNkT6+DmTgVDlpSaoK0S6betcZhKZpX2WCHaLZ4LQULvh07MVd5BTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=I9JvbYmA; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 11B9F411A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739210108; bh=5pQFFPXR2QDI9TXSDTjpQCYuhX/4f8q0mdRA4cKArH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=I9JvbYmAyoZIU8FpW3JD20coUV425VNwnTQI3yxjc7xYVOBhhB74iCPmBJPG064Wv
	 5ruoi2xygOuPjL0lDhmcdp4H3Bx4/AotzmKjZdaSNE9RWqo92wYqhZY4prAkPmnjSA
	 9Km7tml2wtCW6JRbQUut3bFNl3AABKcc6d7fOPDCZad6hUsakF2Wk4YZWEt01SqWNs
	 P9DSKwSwMzJdfWlEcpXqzJd50zbLvBqaedbL+R6LkyQcX3sdgVaQ8G9wztylsUYKR/
	 4uV7SQ7PJ/LNpjPrxd7emAsw2oamsV5QRX47TM75d80aFYt7p4oH00EIMd53oaB5FD
	 hrJEPnMdG0vQw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 11B9F411A1;
	Mon, 10 Feb 2025 17:55:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Charles Han <hanchunchao@inspur.com>, mkl@pengutronix.de,
 manivannan.sadhasivam@linaro.org, thomas.kopp@microchip.com,
 mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, cem@kernel.org, djwong@kernel.org
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-doc@vger.kernel.org, Charles Han <hanchunchao@inspur.com>
Subject: Re: [v2] Documentation: Remove repeated word in docs
In-Reply-To: <20250207073433.23604-1-hanchunchao@inspur.com>
References: <20250207073433.23604-1-hanchunchao@inspur.com>
Date: Mon, 10 Feb 2025 10:55:07 -0700
Message-ID: <877c5x1y84.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charles Han <hanchunchao@inspur.com> writes:

> Remove the repeated word "to" docs.
>
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml      | 2 +-
>  Documentation/filesystems/xfs/xfs-online-fsck-design.rst      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon

