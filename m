Return-Path: <linux-can+bounces-4023-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A2CB0D307
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 09:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6743A50E9
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F19D28DB46;
	Tue, 22 Jul 2025 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HUSR8GAL"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFC6288CB6;
	Tue, 22 Jul 2025 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169276; cv=none; b=PXpuZVgsBDK4AQqwJ8d/xJOYYMPgUXkvVayLb0Xm89nuwjI8zBCQjppx+xowCRCs66kvm5Oz0YsZTung34m8W2bzISheaKmj1unkgfP4Ud2DC2HGpI3kfndElc942y3HA0LAtY4i1l44c0ZRiL8bQJay3Fn0Hs2jsfZV/x99cms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169276; c=relaxed/simple;
	bh=mL7et0eGo71qySIX8F8hfi5V129JjKfUmnon2D29HxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+5O7DT3IYjkjcmGKxDMGhfchI0BZ/q6xT56MSEr2e6bMmM69Ea2kZG8U4efTeEJuDcKd7kaQGM7n+QYJp65FsInKfYqZ/+6Jy6lc5QKSBRiSB080wedRajo9G8gFhqpdNR3k64iU5ikWGsf0Bylhzv5/aCVbTGlxZdc/EPg/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HUSR8GAL; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id e7PYufBAdQ4Mme7PaumBLR; Tue, 22 Jul 2025 09:27:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753169265;
	bh=nNzUP58Ff6/imQfkmCqAaoLXlQhUQy9TroMK5CrSMu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=HUSR8GAL+jau5xsAG5uxbvGFK7PzgCDlL664SZUfx8eyWzz9WgShVO39I6Y7StVag
	 Fpe77Svs1Ukl0c8QbTuNYGjg5vIcZ89R7knN8YzrAr1VFqkL8loVOwXdCpi72A662L
	 zJm5xjiIa6cTmhgPobxf5WD6VoGQusInJgusdDCm1XcStzEKVEW7A+ntqz3sPq7jdc
	 0TTI0jH7E0lx5G0Ui5TAupLlFrKgTif1Q0lD0/P1UoOmazJ4w2Kh66GfHEdBlENLF1
	 Zm6iNnKKhGv5Wek5sbcytnBeNaK6qWpPKx6nGa/6juZz0f2TyJWhVYfC4x9Kr+PMoE
	 +7l2CVihpX0iA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 22 Jul 2025 09:27:45 +0200
X-ME-IP: 124.33.176.97
Message-ID: <399941c7-2ee5-4d8b-a7c6-c8ed7d85b565@wanadoo.fr>
Date: Tue, 22 Jul 2025 16:27:39 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs: Fix kernel-doc error in CAN driver
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>, Ondrej Ille <ondrej.ille@gmail.com>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250722035352.21807-1-luis.hernandez093@gmail.com>
 <b694009f-72eb-4eb9-85b1-db19d93593e0@wanadoo.fr>
 <202507220837.23333.pisa@fel.cvut.cz>
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
In-Reply-To: <202507220837.23333.pisa@fel.cvut.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2025 at 15:37, Pavel Pisa wrote:
> On Tuesday 22 of July 2025 06:06:30 Vincent Mailhol wrote:
>> On 22/07/2025 at 12:53, Luis Felipe Hernandez wrote:
>>> Fix kernel-doc formatting issue causing unexpected indentation error
>>> in ctucanfd driver documentation build. Convert main return values
>>> to bullet list format while preserving numbered sub-list in order to
>>> correct indentation error and visual structure in rendered html.
>>>
>>> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
>>
>> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> Reviewed-by: Vincent Mailhol <pisa@fel.cvut.cz>
               ^^^^^^^^^^^^^^^
Are you trying to impersonate me?

Can you reply again with the proper Reviewed-by tag? ;)


Yours sincerely,
Vincent Mailhol


