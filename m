Return-Path: <linux-can+bounces-4959-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BCEB98FD3
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E153C3A826C
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853122BFC9B;
	Wed, 24 Sep 2025 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBW9kOB3"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C29D2BEFF3;
	Wed, 24 Sep 2025 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704028; cv=none; b=aEcC7vSAIquv3CE0fMta5Ch3o/261AkeNzAIWUARpSnRK+iYa5dA0V/76nejJs6StAQJA58Q7oT0bEc6jI4L2iDQV+pa0V1s88WWPZIuWTM8WoxyGZQ4QiUQPsllyalI+kYyAP7laAMkehqE7GL2c3c/FSfyQ0FlWmjBkc3bIFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704028; c=relaxed/simple;
	bh=ghsGak9SLbf36dyogpamMQUpmUYkTxTL/IVAsMO5FWc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=b5XLtVI1KRrJxIH9PL1ZV6g5paLvfnDluXipoxT6+5SRvhSAgGoYgIA4gc4p8Xsq0Xek/0G4YN+NLobXilwcW0rcKXRGQUI8pL4gvX4461m/QpH556mW6nFbSFLEh40K29kxqmaZorhYUKxQT2BG40Qo1AL7cdNpwjluKZ/HeI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBW9kOB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232F7C113CF;
	Wed, 24 Sep 2025 08:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758704026;
	bh=ghsGak9SLbf36dyogpamMQUpmUYkTxTL/IVAsMO5FWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YBW9kOB3H0y+XMc/eWX8oiNDSM+eazSp8pTl3d0FOW3nz05oXCDEq1go57+lGHLJy
	 2xge3bLDLAvyUBdIB3SBDpKMo/foQSAEnZHEGFkc/wk2f+h+U8b4gyZZXIYD1qYq8r
	 JuzINUEz/7ulT9J0eCJYt/zlUewn80dU+ztet9jzUwsS+M35c2srf9HwRvv2kvgqi5
	 3zUasuOiz6/lTffMicooCErk7e1Z5Y2y1i7e6I/ufrfmvi3aS6voM4HBytIiGqj0Mn
	 umB5VVquM1OtKAwlf/tXg0WFy1UwI2/BbQwr+RQPVNMb4gLDPo8/GCf/eUXmKU/NAV
	 7cB8qhkeD4mCA==
Content-Type: multipart/mixed; boundary="------------jg0dEBfEdtIU7TRisj0uiPKa"
Message-ID: <72ce7599-1b5b-464a-a5de-228ff9724701@kernel.org>
Date: Wed, 24 Sep 2025 09:53:42 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 1/7] can: hi311x: fix null pointer dereference when
 resuming from sleep before interface was enabled: manual merge
Content-Language: en-GB, fr-BE
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Chen Yufeng <chenyufeng@iie.ac.cn>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250923073427.493034-1-mkl@pengutronix.de>
 <20250923073427.493034-2-mkl@pengutronix.de>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250923073427.493034-2-mkl@pengutronix.de>

This is a multi-part message in MIME format.
--------------jg0dEBfEdtIU7TRisj0uiPKa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 23/09/2025 08:32, Marc Kleine-Budde wrote:
> From: Chen Yufeng <chenyufeng@iie.ac.cn>
> 
> This issue is similar to the vulnerability in the `mcp251x` driver,
> which was fixed in commit 03c427147b2d ("can: mcp251x: fix resume from
> sleep before interface was brought up").
> 
> In the `hi311x` driver, when the device resumes from sleep, the driver
> schedules `priv->restart_work`. However, if the network interface was
> not previously enabled, the `priv->wq` (workqueue) is not allocated and
> initialized, leading to a null pointer dereference.
> 
> To fix this, we move the allocation and initialization of the workqueue
> from the `hi3110_open` function to the `hi3110_can_probe` function.
> This ensures that the workqueue is properly initialized before it is
> used during device resume. And added logic to destroy the workqueue
> in the error handling paths of `hi3110_can_probe` and in the
> `hi3110_can_remove` function to prevent resource leaks.

FYI, we got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

  6b6968084721 ("can: hi311x: fix null pointer dereference when resuming
from sleep before interface was enabled")

and this one from 'net-next':

  27ce71e1ce81 ("net: WQ_PERCPU added to alloc_workqueue users")

----- Generic Message -----
The best is to avoid conflicts between 'net' and 'net-next' trees but if
they cannot be avoided when preparing patches, a note about how to fix
them is much appreciated.
The conflict has been resolved on our side[1] and the resolution we
suggest is attached to this email. Please report any issues linked to
this conflict resolution as it might be used by others. If you worked on
the mentioned patches, don't hesitate to ACK this conflict resolution.
---------------------------

Regarding this conflict, I simply added "WQ_PERCPU" flag to
alloc_workqueue() in hi3110_can_probe() -- the new location after the
modification in 'net' -- instead of in hi3110_open().

Rerere cache is available in [2].

Cheers,
Matt

1: https://github.com/multipath-tcp/mptcp_net-next/commit/4ef39a01f1f0
2: https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/1a8b8
-- 
Sponsored by the NGI0 Core fund.

--------------jg0dEBfEdtIU7TRisj0uiPKa
Content-Type: text/x-patch; charset=UTF-8;
 name="4ef39a01f1f0d195d0d4daae6312d1ae71d59188.patch"
Content-Disposition: attachment;
 filename="4ef39a01f1f0d195d0d4daae6312d1ae71d59188.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIGRyaXZlcnMvbmV0L2Nhbi9zcGkvaGkzMTF4LmMKaW5kZXggOTZmMjMzMTFi
NGVlLDk2M2VhODUxMGRkOS4uNmQ0YjY0M2UxMzVmCi0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9z
cGkvaGkzMTF4LmMKKysrIGIvZHJpdmVycy9uZXQvY2FuL3NwaS9oaTMxMXguYwpAQEAgLTkw
OSw2IC04OTYsMTUgKzg5NiwxNiBAQEAgc3RhdGljIGludCBoaTMxMTBfY2FuX3Byb2JlKHN0
cnVjdCBzcGlfCiAgCWlmIChyZXQpCiAgCQlnb3RvIG91dF9jbGs7CiAgCiAtCXByaXYtPndx
ID0gYWxsb2Nfd29ya3F1ZXVlKCJoaTMxMTBfd3EiLCBXUV9GUkVFWkFCTEUgfCBXUV9NRU1f
UkVDTEFJTSwKKysJcHJpdi0+d3EgPSBhbGxvY193b3JrcXVldWUoImhpMzExMF93cSIsCisr
CQkJCSAgIFdRX0ZSRUVaQUJMRSB8IFdRX01FTV9SRUNMQUlNIHwgV1FfUEVSQ1BVLAorIAkJ
CQkgICAwKTsKKyAJaWYgKCFwcml2LT53cSkgeworIAkJcmV0ID0gLUVOT01FTTsKKyAJCWdv
dG8gb3V0X2NsazsKKyAJfQorIAlJTklUX1dPUksoJnByaXYtPnR4X3dvcmssIGhpMzExMF90
eF93b3JrX2hhbmRsZXIpOworIAlJTklUX1dPUksoJnByaXYtPnJlc3RhcnRfd29yaywgaGkz
MTEwX3Jlc3RhcnRfd29ya19oYW5kbGVyKTsKKyAKICAJcHJpdi0+c3BpID0gc3BpOwogIAlt
dXRleF9pbml0KCZwcml2LT5oaTMxMTBfbG9jayk7CiAgCg==

--------------jg0dEBfEdtIU7TRisj0uiPKa--

