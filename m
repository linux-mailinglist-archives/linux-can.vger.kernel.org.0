Return-Path: <linux-can+bounces-6393-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDitFoQ5e2mGCQIAu9opvQ
	(envelope-from <linux-can+bounces-6393-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 11:42:12 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EED86AEF9B
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 11:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3155B301BD67
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 10:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A1232FA19;
	Thu, 29 Jan 2026 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RP5E9VOR";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Yc9WRDHJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D73815FE
	for <linux-can@vger.kernel.org>; Thu, 29 Jan 2026 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683052; cv=pass; b=Z100FcgogzOmDBKlRJq4fB6EhdUZcLhzyYirHsMprm9z+9Ns1kK3VsgCTlMAstiw3ZkfOMk4Yjr5kPIIPKyoOwoL5FBfQrCPQwoVnORo55Xg5i7rq1SDlatrwVNMV4gedxqTUqBywOFlCegLolQaU8rlXH+7iSQsQhN07jt95AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683052; c=relaxed/simple;
	bh=G/tiNs/mTMgpa5d7vl2e0jVlBVjtTMVTj/k/KEXQ+bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFhpAElLbWQb0smna8meBOFMPjzA6SXzEcO92PUmhCiJ6yu66sg5UI23Jx3P7jk1IrCNTbp9Q3hl2AZ/gOMH6+D8CBz1dOUoL5pnO8zr5OtBLRCGQqMCka6VaKu9wfR6IbemKDk4BpgauQQjx8YPnIfXp5aMD/wpiTzPyu+XoiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net; spf=none smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RP5E9VOR; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Yc9WRDHJ; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769682678; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a/T6fMWNY6f9ILUxlwRkACXk8+X76U9ja/z2+l2cQBdYW3jmCE7ApZlDNWRW9BUJwU
    8TjcD3HjM4byjTYsbJaaCQxuRwleUMwWOFUUi/nUvzHD6jObiAyfCxUEWQQmY+0QWWog
    smsaImGxlD8HMJGCO0iamdO4n7VdywZt93jchZEzYNimRClHINAdEih7KlAS9Y0FT6gH
    eFWYA3zGY6s9slJLrLwroeZmZvJiTrUdKLPT5jGSdB0ueUwpSOrzwKP/FjcJmcxjpoTS
    XSLCl+aoNgxsDW9+WO15/sIRdMOD4YjgekgJ2MWVR3bYRK2GYahOMMNScqLnEQiE/1dk
    v87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769682678;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JqlCT0IG00qKTvNDZ7jbSBuWB4pRFgJ4gt42VupvEOA=;
    b=WtfKyy8g3ToqrxOt0CqI3ysM7oVyf+i9aQmnG84qrymfYuFuDUIPjjKCeJE+Ws48rI
    n5qFawYPCtTd58nFUTwMxgQkIDGwF9HbDJYt6BOkoDP9Hz4CgQC4TMJNy7WWJuzGdmoJ
    LR7rt01VVUSW/r/4H33dZT+TbAbYTl2JLKO5gjP2eB4WAIH0MZnKgjVFbwbAh8hzTsRp
    ErrPNNNhcdM8pwEXdapLG8f7qjTd8WCAnAsxI75ydvfh9Us167NipOtE52iSI7EQoLsj
    39IduSaXaMmRAZoOoKFyd14VUnNGUZqGFOLBF6i1Bbvyp0dyt84IQogsZBhUyEDx7xPn
    PcVw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769682678;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JqlCT0IG00qKTvNDZ7jbSBuWB4pRFgJ4gt42VupvEOA=;
    b=RP5E9VORGjn/7BZu5XxIAUMHxPLAeLxDDyhz4RVnPfa5WHmRmcM+gvPnhRkLvYK58J
    IuTjcZpttLiDh1uwU6gZpVJ2I8VLx15bm8pB439NzmKY/AHEBte9eUc7yKFkGWjZPDZE
    rjnSj4uUP7cpHnv7tqy8Xytw1MNMbGPluepl03rFieTwLOYJNztcZ2zhHXm6yFKeguf+
    /xqoWWUEZeObyeod0bATfRrSu9wkAtjVCK/BBDnHpoRsG9673nqeC+yxtPKi7FVP3aHj
    ySXhznMSLGJbD6gQIFEHgCWrGDRyDyinuLHVdG4Up7+cSA1sxQxsZhv8qF6s4qd8nqCh
    FmiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769682678;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JqlCT0IG00qKTvNDZ7jbSBuWB4pRFgJ4gt42VupvEOA=;
    b=Yc9WRDHJSH9uW2TspdOpfRjpfXwgSn8MsoxHG5xGKqDZcmabfcckn39K0HnpJEqCpW
    ArIFaZTczoISPtYX4FAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6810::76e]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20TAVIqx4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 29 Jan 2026 11:31:18 +0100 (CET)
Message-ID: <1d9966d9-877f-46d4-a2a8-56b6d621bb36@hartkopp.net>
Date: Thu, 29 Jan 2026 11:31:18 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: b4 prep --auto-to-cc fails with 'NoneType' object is not
 subscriptable
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, tools@kernel.org, users@kernel.org,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
 <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
 <20260129-versatile-tuscan-mongrel-f9b173-mkl@pengutronix.de>
 <f47126ee-8256-4077-a09c-47a1ed461f65@hartkopp.net>
 <20260129-fortunate-pompous-chinchilla-dcb99f-mkl@pengutronix.de>
 <c5e95a45-9aac-4a67-82b5-ac4ed8ae2844@hartkopp.net>
 <20260129-skilled-placid-lori-f58fb9-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260129-skilled-placid-lori-f58fb9-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6393-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pengutronix.de:email,davemloft.net:email,hartkopp.net:email,hartkopp.net:dkim,hartkopp.net:mid,get_maintainer.pl:url]
X-Rspamd-Queue-Id: EED86AEF9B
X-Rspamd-Action: no action



On 29.01.26 11:19, Marc Kleine-Budde wrote:
> On 29.01.2026 11:09:50, Oliver Hartkopp wrote:
>>> Latest version is v0.14.3, please re-check.
>>
>> $ b4 --version
>> 0.14.3
>>
>> Same behavior but different line numbers:
>>
>> $ b4 prep --auto-to-cc
>> Will collect To: addresses using get_maintainer.pl
>> Will collect Cc: addresses using get_maintainer.pl
>> Traceback (most recent call last):
>>    File "/usr/bin/b4", line 8, in <module>
>>      sys.exit(cmd())
>>               ~~~^^
>>    File "/usr/lib/python3/dist-packages/b4/command.py", line 417, in cmd
>>      cmdargs.func(cmdargs)
>>      ~~~~~~~~~~~~^^^^^^^^^
>>    File "/usr/lib/python3/dist-packages/b4/command.py", line 83, in cmd_prep
>>      b4.ez.cmd_prep(cmdargs)
>>      ~~~~~~~~~~~~~~^^^^^^^^^
>>    File "/usr/lib/python3/dist-packages/b4/ez.py", line 2907, in cmd_prep
>>      auto_to_cc()
>>      ~~~~~~~~~~^^
>>    File "/usr/lib/python3/dist-packages/b4/ez.py", line 2727, in auto_to_cc
>>      logger.debug('added %s to seen', ltr.addr[1])
>>                                       ~~~~~~~~^^^
>> TypeError: 'NoneType' object is not subscriptable
>>
>> I upgraded my machine from Debian Trixie to the "unstable" Debian Forky.
> 
> nitpick: Forky is "testing"

Ack!

>> I didn't fiddle with https://kernel.googlesource.com/pub/scm/utils/b4/b4.git
>> nor pip.
> 
> Try the b4.git, you can directly use it after cloning. I'm using it
> successfully on Forky.
> 
> Marc
> 

Aaaahhhh!!!

~/net-next$ ~/b4/b4.sh prep --auto-to-cc
Will collect To: addresses using get_maintainer.pl
Will collect Cc: addresses using get_maintainer.pl
Collecting To/Cc addresses
     + To: Marc Kleine-Budde <mkl@pengutronix.de>
     + To: Vincent Mailhol <mailhol@kernel.org>
     + To: Oliver Hartkopp <socketcan@hartkopp.net>
     + To: Robin van der Gracht <robin@protonic.nl>
     + To: Oleksij Rempel <o.rempel@pengutronix.de>
     + To: kernel@pengutronix.de
     + To: David S. Miller <davem@davemloft.net>
     + To: Eric Dumazet <edumazet@google.com>
     + To: Jakub Kicinski <kuba@kernel.org>
     + To: Paolo Abeni <pabeni@redhat.com>
     + To: Simon Horman <horms@kernel.org>
     + Cc: linux-can@vger.kernel.org
     + Cc: linux-kernel@vger.kernel.org
     + Cc: netdev@vger.kernel.org
---
You can trim/expand this list with: b4 prep --edit-cover
Invoking git-filter-repo to update the cover letter.
New history written in 0.41 seconds...
Completely finished after 0.81 seconds.

~/net-next$ ~/b4/b4.sh --version
0.15-dev-47773

Then I can remove the b4 Debian package again.

Thanks for the support!

Btw. that it does not work neither on Trixie nor on Forky out of the box 
is not very satisfying :-/

Best regards,
Oliver

