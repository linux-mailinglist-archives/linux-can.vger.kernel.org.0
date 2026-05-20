Return-Path: <linux-can+bounces-7667-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFfQGPCoDWox1QUAu9opvQ
	(envelope-from <linux-can+bounces-7667-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 14:28:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB65658DA52
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 14:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68C343028350
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 12:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1A3D7D82;
	Wed, 20 May 2026 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="IyeQYiiY";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BO0iBWMn"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB53A4505
	for <linux-can@vger.kernel.org>; Wed, 20 May 2026 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279487; cv=pass; b=h6fMJmZOogXHr30U5VQjLHnx6maU49uE+fb1qXKKTvVg8EABh3fyVZJJtGrEkPKF+EbaIiIgLy4J+KOjFiMXRnL8h7w/wrYienzWvVZC++WCbFZA65HopJhncaA0XZcegrJbiaYRZsVYQVUclqJ1CWcFmvY4GMkqmK1YexoD4xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279487; c=relaxed/simple;
	bh=F9czB/FqWcLcCOVHHUDGqDCFFRw+4uzIX/NmGbE4vxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BLbmYEuNsDfnEoVtRjVEQaCuIKCHzUOxPj9KdicmDE372GWHo3j9FaOseIMEEPmIgQkR3ywEYduYf/COTiSt+nYdyuf8UqQfdobHQC+JJJ9EMiEFZiKqV0UX4Z3AnUJsD2ZcCOphTEFAc8Z8GM+hCRXjYI96VikUvLrngKVJfSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=IyeQYiiY; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BO0iBWMn; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779279301; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sUwGotjFzW/P0kXnjFUoafgrTfZ41pd7aMsgN9iye5RpXKFAo5Ib5KT7Wz5TZKWxsO
    nuMiPErekEpzNu9On/yiMNZtGy8pcRlPltK1JfT66O9LgAXrYrTsO3K2SjWEpBPYRPCn
    Karc3Ru2gHMk5nG/WyhwxS9sD8YJUNnKPnFZKwMuRJKGKyDuapulDtSIXuutltNSfQ6e
    zkQO1MF5DfU/h35//I5e741vP688puq8Fka5ev6Imj8NTh7nR+/MUOjBo3V5W0msZ6kK
    ZsL9DxO7YmoMNLSVXmblf6hZAeWe+jtgbtunGsU46nWDSwVtmLoV126Xfd3BhUkenZx+
    RteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779279301;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=mBjTfcp3D7E7kRpp/vu04xRLPP8ISPkUSWguvsSrL0c=;
    b=ScXZO4lkZ2BwZBT7wsKVYkFIS0gh85gIzfwQbdbp258AWEvFSUHj/wFdbmbZhW1hpm
    xupPBw7oDEc2PUdjj5sFUQvCU8xH130lstKQqllLbJXXuhyI95f5zBsM6nnxERBH2DMh
    eC67u29UFOzhcrZls4ODHTOhWvMoRi1oHStbalezXh5gfAUvqdQPX9QZDIcIYbS6ciUo
    GMKBjJ0sG8GeqDhc5MKpznxpuIyl7Vx1MMqc2d+ETCJ1Rf6zBZwNC8cdKf9/hbAx5Ckp
    H8eNgVn1yZ4ghS3MjcwwkLBBSjnoiZX1byw3isddeyT1nDUHpVNsa6ouF9Z2TR3jWlI+
    Itng==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779279301;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=mBjTfcp3D7E7kRpp/vu04xRLPP8ISPkUSWguvsSrL0c=;
    b=IyeQYiiYrtO8R5i1QL1y8pKSoE9QCLc464gtsDmFe9xla34AZv+l4gcxCM8Fs7eNSd
    Fh6EEkBgXMzMIa3M/urGa7Z5zGN3D+JvuKIj27de158BIz0itiGwGAvFTg3bm4BCJq5B
    UZrbNF5U1GTcCD1wTBlPY7IOc+f0+Iu9MBwdm2UaZiNoF/rBxV+pgGK6Tuq6hVhEv0cC
    UGl/Dq9wdkwEBrL3WYJHE9Cql+shVhqnh1868CCrhJRbp3cllYGXTaZDmz0X1f/0uAUO
    pMH4ccHX/FxWXBSlbDP4qzih95MuC4LytIJYFYmf9x8ozin6KEbk9OfwQS1ccweIkKXQ
    5XlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779279301;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=mBjTfcp3D7E7kRpp/vu04xRLPP8ISPkUSWguvsSrL0c=;
    b=BO0iBWMn+5dE3t3wRYKXMEQVeGfpfX5wO9+RFac1cc+9E1A0NpSY9sQ0tI8X9AI4TW
    0Se1wnLVA3sKOAIounCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24KCF0LFG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 20 May 2026 14:15:00 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 0/2] Fix two KCSAN issues
Date: Wed, 20 May 2026 14:14:48 +0200
Message-ID: <20260520121450.27964-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7667-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: AB65658DA52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Patch 1 supersedes the "add locking when updating filter and timer values"
https://patchwork.kernel.org/project/linux-can/patch/20260219-bcm_spin_lock_init-v3-2-c61026740d7b@hartkopp.net/
where the readers in softirq/timer context have not been addressed
correctly and some comment was insufficient.

Patch 2 fixed an issue that has been detected by KCSAN when I was testing
patch 1 ;-)

Oliver Hartkopp (2):
  can: bcm: add locking when updating filter and timer values
  can: bcm: use atomic access in receive statistics

 net/can/bcm.c | 88 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 19 deletions(-)

-- 
2.53.0


