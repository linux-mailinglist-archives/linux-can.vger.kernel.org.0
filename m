Return-Path: <linux-can+bounces-4021-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075A8B0D0C9
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 06:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 221457AAF1D
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 04:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152E71E260D;
	Tue, 22 Jul 2025 04:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Ahw/tErK"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7E4C92;
	Tue, 22 Jul 2025 04:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753157219; cv=none; b=RQ6p72m2Zxkq53eeVZZWIFaWQ060n9oXicWC8NQ57bV+ZHnYztc+MYzQSUdA5mzBi3SP5wFsc8DuchHPDYHADYhlGA3xBxdnPjPXjPAQZDTupSeqK8FpSmyJAhKxOtTvRNVPAgc2hGFYPOgoUggtQ1GQLTDaH6GXYngIR46IsI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753157219; c=relaxed/simple;
	bh=DksJq6U4T79Wss2lLMWXRLoPWNWlUcvBmkKidpUyDJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDGLpAGLc6dAOcts59C+VEhPq2XKEQVtkfYitumvQoAp2cH8KJfqH2Qn4xmcwsocEmmLZm0L7k5cDeHyMjbdb9/EEJveW0crYYiZbTftpJV7+EWFA0oKaQ8wMTu0Do4AJ7ODaD8CoD8+8VBSnHdDC26zPURkUXVn3BbqN13zTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Ahw/tErK; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id e4GtujGi6iIEfe4H5uOC6v; Tue, 22 Jul 2025 06:06:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753157206;
	bh=4RzBDqGcoBlfqeVv8Mo59T70/L1mwoJnXaIHqhGtjHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Ahw/tErKuGBJ2G3enZMo2S8Kv+l55At31yp01uG/4fOaaQqVgpn0sWHEQCfkGqjXb
	 dbavixgHO63aCEyi5yFIf3RYm1/HGeTP705ncYzXUWAlJl7Ru59PEs3u+ToZj8ujWb
	 gRs9kGiF+uhbEYXjrs4Fw0cDXRV7mR4vxl10rfN63/M8HYzvCZ8or7pAbNYMu5mDxb
	 iICXBr5n2ZwqnQK89LXNYoujtdnU1tfcQbKvJYQhPIqB2ylgQZpvHV394pb4yo4qja
	 ezO555dDDy1U1bB/qLU0bTHREj1F3u8K7p8fDBqCfZc4THJZh6Kgq3gYIyxg0hbwrD
	 QMlScWgKWnT2g==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 22 Jul 2025 06:06:46 +0200
X-ME-IP: 124.33.176.97
Message-ID: <b694009f-72eb-4eb9-85b1-db19d93593e0@wanadoo.fr>
Date: Tue, 22 Jul 2025 13:06:30 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs: Fix kernel-doc error in CAN driver
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Ondrej Ille
 <ondrej.ille@gmail.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250722035352.21807-1-luis.hernandez093@gmail.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250722035352.21807-1-luis.hernandez093@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2025 at 12:53, Luis Felipe Hernandez wrote:
> Fix kernel-doc formatting issue causing unexpected indentation error
> in ctucanfd driver documentation build. Convert main return values
> to bullet list format while preserving numbered sub-list in order to
> correct indentation error and visual structure in rendered html.
> 
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


