Return-Path: <linux-can+bounces-4833-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29365B9453C
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F6E3B91A3
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C8830EF82;
	Tue, 23 Sep 2025 05:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbINurvy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97D30DED5;
	Tue, 23 Sep 2025 05:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604429; cv=none; b=HtQLODZ/nTOb3hbBDn0VQERFWj4s6e2TVTQzPSrLtOAJz3UyIRU3EEhQYpsEXF1nIDnY0WhEPbVDHPq43mE/E011dJynndddMVHxzPg+bC0Q+6Qhl32Lv/OzOfPHXu0WQuiFJVe12vcpWhtbvIW5k/nPatRAEN8YT+Iz83Pfir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604429; c=relaxed/simple;
	bh=95QfD7ryptGLeKDTr9zlYWdeDiNsQmebIMahLNm2Wns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQY2B9NkfuU0St/tfEmojGdSm17/IxIVHID1dF105C/gv7MafFgsBt+4RDNXhWzf8vs+xEbxUenSq4a3uvv0MWQcup1A6esGMv4ypP13Hj+nDzYFZLXCdMW5yNviI5KpXtkxx0IFx2Ao7f7j73STpgLJrU9RhC2SEqy7AeLoYy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbINurvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A213FC4CEF5;
	Tue, 23 Sep 2025 05:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758604428;
	bh=95QfD7ryptGLeKDTr9zlYWdeDiNsQmebIMahLNm2Wns=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gbINurvyJI1xdWkQCkZMU7n+XGNncQf0mBffG6W/ahJlCpi0wLpdnRgpQbWLmh2bQ
	 DbiMfTeHvT1N4VHpSMZReN743tB7aICUurP2ctjgfoz5dfJ0tR+Y39ea6e60N1F9ey
	 CLa+dALbCK844yWNpNAkYuRxll78ANZngyTDu4eWUwg4iz8fa4PrlDFTdzuboNpGaZ
	 1nfXWY2yc6ysfeR95IrssZEln6xqW4RHmtraC+05Xhn3AL1dXcnml/GBCZpTNcBdvx
	 l6pbdqvWTMsVCyJb7MAhonrT6p7TlE5nM6I4d2gxn26t6SwEC5ThqBGAjQZkSrNzVD
	 /VkvlxxiI4jFA==
Message-ID: <e69ba85c-d3c9-4349-bcda-9e93a676e993@kernel.org>
Date: Tue, 23 Sep 2025 14:13:46 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] can: rework the CAN MTU logic (CAN XL preparation
 step 2/3)
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250923-can-fix-mtu-v2-0-984f9868db69@kernel.org>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250923-can-fix-mtu-v2-0-984f9868db69@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/09/2025 at 13:52, Vincent Mailhol wrote:

(...)

> base-commit: 9b277fca90c39c8b749e659bf5c23e924c46c93b
> change-id: 20250915-can-fix-mtu-050a94b563a0                      ^^^^^^^^^^^

I messed-up with the change-ids. This was supposed to be:

  can-rework-mtu

Well, the hash is different, so this should not collide with the real
can-fix-mtu series.


Yours sincerely,
Vincent Mailhol


