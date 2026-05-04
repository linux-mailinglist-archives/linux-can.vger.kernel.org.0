Return-Path: <linux-can+bounces-7479-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F7QD0JV+GmWtAIAu9opvQ
	(envelope-from <linux-can+bounces-7479-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 10:13:54 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 929C14B9FEC
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 10:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 655D730470EC
	for <lists+linux-can@lfdr.de>; Mon,  4 May 2026 08:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285BA314D34;
	Mon,  4 May 2026 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UzpUFEMh";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OkPfngL/"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6793090D7;
	Mon,  4 May 2026 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882127; cv=pass; b=m81YqIsjGBbOeJrOYAyJ1wRfGZwZEaGfiWzqCsKRT5xir/ReV8jzcxJ/C0RUhX2fsEljDPGNfmbUHvZCawLLYQTH/gbfEgSX5vTMp3TLu29/qXnKYUp+MTFGMhXP+89eG76AMq5xqaKIOp6IZnaWto1HKSNKevocAqbIcRGKQrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882127; c=relaxed/simple;
	bh=AwF48YxAXV3zGYiRpd3T+kMK/aKWa+nsp1c4sQs11z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6jmizVPzJ6qGvtFGCnBnirZPAoc6QdSMXHThAw/OBx2ZcDyaFp1yPQ5DUxlfXT6tyAW/Fg1OZxql7PPwkOFLVEiI/z9yYOX7cdb8I3zJsXoruXIDoMG8kGl5TynwV//vp9PiiYzUvTJeNQhbDJLowMpEi6YYKIPVwyFdxlSF18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UzpUFEMh; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OkPfngL/; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1777882109; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UtCeqmBfLqjEzwZhAFsf2CoOVFK2RIjLmmq4zSUKjgZiXr8xdgLYZkmrWiBqPQ5Pvb
    yudPjFasJxpXh5qoYrn3KseGxvyvnXG+t3zQ0uZpGaaU5UxGgbMqtP+KMt+zQFMfe8ae
    dzIkxShL/by5S/0QH3UVWmIs2tMNhklGBSbW6hgV3Unw8o6bRO/RgwC2u1FLDz00Iqx7
    XLLxpVZ9f+7JDdtmoo6Z78pwQAmgDKjdddJTF2hVvj6Ti9tQqwBpfbWKw85o5QS562wH
    dnWjAtZUVDL8Nzzf53xW5AybvDhipX82dAhTBiCiRHe20OYMtd7jxfcek5mx8s9rJs4B
    IIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777882109;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OztcoMbb1P5FFRmOxJu3ufdy/cphrBbxVGEbwg+CL04=;
    b=WH49glsEwGLkwAOhU4/54wFtDgIHS4Gwhs9IO828+3vcDQc99j6gZXUNBE0aJR4zeY
    18Ppz/dzPDF6etxOSBTY32NBRkyMqGQmllj9otWdDKfWvP1SMNx5Qb0NHlB9OfD4ZVpN
    +suZZxk10anCByM4cHeKjXO/6pi4wGSwVCmNYl8fI5KUchoGaTUqRoheFa74yx8h00Dp
    UoDSf5tkDimOSqoSZEuVM7O1HsQs0Vi3rMIcdL8VvtRzng45YxBWWgQdu0UTOl5qNNeZ
    DQH8aBeSvuzymCtVJ+pBldWqdPnUn+NjPempFZEjYZXr+qCzqiieniCIGgR+FZwxTCUp
    lRrA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777882109;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OztcoMbb1P5FFRmOxJu3ufdy/cphrBbxVGEbwg+CL04=;
    b=UzpUFEMho1BGFstd0g6P4+aLThuNxqrh2oQCiAaFpn1Ue6RfxcMdvMjF5sR7epWwfm
    wZ6avOcLlLxGHQvUWJEPfKNKNN4D6mlpm/gFvWlyDE8+ZMwCN2pbC/9MVSY2FC28tDtD
    /ILz0DqL8LUEBfSm3mGmI4/qHHIO409/+sgDswK4X8HCZo3cJQm3qB7o4Nl/+CbPNShX
    bYvt9ToDiL/ocDiJb3NbO1D7LRtXz/qFivz4rmKVhkgX4tEeuaA3xXBw+ATqTaVoQn9w
    lw4MBAZvwctiZmk10ksmnVNPGK0EEy2JaWvrki4kbL6RwZ7lfdChTPa0gXWIhf5a85Kb
    MLyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777882109;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OztcoMbb1P5FFRmOxJu3ufdy/cphrBbxVGEbwg+CL04=;
    b=OkPfngL/UKMKGfCUzv1Lph0W+aDk3j3L+NpASYcwy3Q78sg54ORyGYu7By19YDkrM1
    y6Weg1LACEUD8MwET0BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s1YTqptmo87qzm6sElmZEI+VN6rw=="
Received: from [IPV6:2a00:6020:4a38:6800:3499:34c0:1f42:76da]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24488SLgp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 4 May 2026 10:08:28 +0200 (CEST)
Message-ID: <bc3edf17-3759-4bfd-bcca-bb9609fa1acb@hartkopp.net>
Date: Mon, 4 May 2026 10:08:22 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] KASAN: slab-use-after-free Read in raw_rcv
To: Eulgyu Kim <eulgyukim@snu.ac.kr>
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, byoungyoung@snu.ac.kr, jjy600901@snu.ac.kr,
 Vincent Mailhol <mailhol@kernel.org>
References: <c744de46-14b3-4902-bf36-50492992007f@hartkopp.net>
 <20260504040839.20805-1-eulgyukim@snu.ac.kr>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260504040839.20805-1-eulgyukim@snu.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 929C14B9FEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7479-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:dkim,hartkopp.net:mid]



On 04.05.26 06:08, Eulgyu Kim wrote:
>>>
>>> Can you confirm that the below patch fixes the issue?
>>>


> 
> Hello,
> 
> thanks for your reply.
> 
> We have tested the patch, and our reproducer did not trigger any issue.
> 
> As this issue was identified via fuzzing and we have limited background,
> we find it challenging to provide further verification.
> 
> At least for our specific test case, the issue seems to be resolved.
> 
> We hope this testing feedback is helpful.

Yes, it definitely is. Many thanks!

We will discuss the best way to add the suggested locking to the code 
here on the linux-can mailing list and then send a patch having you in 
the Reported-by tag.

Best regards,
Oliver

