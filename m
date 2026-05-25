Return-Path: <linux-can+bounces-7703-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ap5bJILfFGorRAcAu9opvQ
	(envelope-from <linux-can+bounces-7703-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 01:47:14 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 633D85CF32E
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 01:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CD973018085
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 23:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D536261B70;
	Mon, 25 May 2026 23:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rU8Qq/bN"
X-Original-To: linux-can@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63789156F45;
	Mon, 25 May 2026 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779752830; cv=none; b=G4tiHJQWm5JC/QK2p+zniIGo5pbB02PlaItxjA4A7sUqV7C7Tmt8c5D00JqKZ2MgOHxrc34zLiPr3l7tCwRHRWrh2Flm8AMjuoTUYxmjWtap04y274KeLRtqo/9CWvPLKOP7VJ6nLGobX+9kz3rBtR3bVxQNaR8RmHmtB0+eggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779752830; c=relaxed/simple;
	bh=/g33kS1qCjT3FOWueVIycEFcWvzJfyp+AL5lFddXtQg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lRItdTeNwpPWofSFB6bAGOOmoe5Lr0U6ROak3pe6RqLu+xsQ7HJej02Ru92J0Q+U5kIOyLS90l7Ghnbt+2TOJ3lksbVJ4C9nc5DPSClskDMjjUSUf2vUMqLB+Rra1r31O2pemPXQSOmGCuvHzf9LHFPfo8bM0KzlcsUiZDLPSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rU8Qq/bN; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1779752820; bh=4sOC29day+/n7VOfFybcwJ5SojI5CMHSaZu00UgnAw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rU8Qq/bNqSgnY0bgE0Wlhl5vwYSqDQFAWYgsaxdmKq9zi3zFQwVpLJv4yIouAmm4m
	 tNSH5FPsXGZIzTzWj6OpJb/Bbz6TyCniqTZYLWLZxVQcKoRMaTNjNImmyb61JmyKko
	 XmyhFwfu6EdWAiFdbJMquKEtwWb+CloBWhKGsxoU=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id BB934C01; Tue, 26 May 2026 07:46:57 +0800
X-QQ-mid: xmsmtpt1779752817tbm3ywxez
Message-ID: <tencent_59FEDDAE991CCFC48D9A25A48D82923A5D07@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+kJequPVCv9dw5Hybe5uwCDrVKDlKsUSmPM/S0+HN4S4OqEuQGa
	 ke6hygRpWEsMIftIQ3zykeiS0ZCZapgDlFfWyzT+IkBHadNIudvB9L2ZrfgXFLtPi+zd8ShEC1mS
	 W6dHKhsgket4bk5OXOLvOFVHCVzbbemDXwaVVeCFSYBMOuYaEt9z6YxHegMbdiZTsxHTOGU0pf6b
	 Q0ijlBO8bNyzrAdROuP3xlIWrQiuBir3QY6xz5EHoqCuSUEinBx3nfulU9oDhgWyjTyDUwbq9gx4
	 DU+RT/F7Ir+xxxLadiCe8tH6AjrlAjhSGnf7l5tT/RIiTa1xjIK/gzH0brhQ8arS11q1ILsHe/UO
	 2IXaxwMiyYdW5FaWQ+FjHdcMDoXNKRFxYBZcSGw4pXeBeiPykqg2rAeLojNvhjBhTEkS2/S0n4jp
	 alfnKIEh8sYG+EU/79P56GGjZi5TdietZnlqNZgHypTA8ZE/KZN6gMIwtakZXLXhEXPfI6Z0D6Cr
	 kjvMFkObsYLTu7bjqyJxHuK2IqY5CMYJVuoGzU7buYm9y7bhW1qh3903UixTI3fxrUlaKZjdToV9
	 A1ylnpp92pP3xlisA36fk4eITcqNznaB/e8SuI3NVCMHccLDaUjYUdYIdH4EGSSiskpt9FDsMKEm
	 1rCaOFvp1ZfOlzlCp3+d9E0SlXR3X+28tU3zOGTjZbRCzQ3o2HRGXOO6PwF0351s0N0WqSIyzXyp
	 nSLak02vaqj1SWHoxC4Cc3IHtI4ekJx5wfIZ6tP6N35rxOyg0TrgIHYYuqrCD4xESvvvrz+b10S6
	 NYKY4sVbq1neM+FzCS+UP2Y2J/bjnzJiNrEm215YwqpDYmU/9116+h6C41wbvGoVD5E1PBAJnhWf
	 XNMJP1JGvlVy/ktTUwKPAzbzgGx8O9amjIHldgrVJzQnPNjuoGYYqWVleZ1CvtpQyfYRnV5h9x7S
	 b/k9E6hOaqu0O7vPfSigpNF5nYYUZTQbvFpoND+4E/AIiy/sKJGG0e21EcaDrIXvq8hcpDrTGCHg
	 lxEnIRuf7pAo6ozXYHTGnColoA5mNgjLFWLizXdg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Edward Adam Davis <eadavis@qq.com>
To: socketcan@hartkopp.net
Cc: eadavis@qq.com,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mkl@pengutronix.de,
	syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] can: af_can: reject can rx unregister if dev is not can
Date: Tue, 26 May 2026 07:46:57 +0800
X-OQ-MSGID: <20260525234656.163746-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d80a783d-d6b3-4a70-944e-8eb9b0000e11@hartkopp.net>
References: <d80a783d-d6b3-4a70-944e-8eb9b0000e11@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7703-lists,linux-can=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[qq.com,vger.kernel.org,pengutronix.de,syzkaller.appspotmail.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-can,8ed98cbd0161632bce95];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:email,qq.com:mid,qq.com:dkim]
X-Rspamd-Queue-Id: 633D85CF32E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 20:15:21 +0200, Oliver Hartkopp wrote:
> > When a user binds a non-CAN device to a socket, the vulnerability reported
> > in [1] is triggered during the socket's closure and release phase, due to
> > the inability to find the expected receive list.
> >
> > Added checks for Mid-layer private and type during the rx unregistration
> > process.
> >
> > [1]
> > KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> > pc : can_rx_unregister+0x124/0x560 net/can/af_can.c:537
> > Call trace:
> >   can_rx_unregister+0x124/0x560 net/can/af_can.c:531 (P)
> >   isotp_release+0x500/0x9d8 net/can/isotp.c:1232
> >   __sock_release+0xa0/0x1d4 net/socket.c:722
> >   sock_close+0x24/0x38 net/socket.c:1514
> >
> > Fixes: bdfb5765e45b ("can: af_can: remove NULL-ptr checks from users of can_dev_rcv_lists_find()")
> > Reported-by: syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=8ed98cbd0161632bce95
> > Tested-by: syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> Hello Edward,
> 
> many thanks for your investigation an effort to address the syzcaller issue!
> 
> Btw. the root cause of the problem, that the receive lists can not be
> accessed is the bonding process that the bonding driver mutates
> and modifies the network device states to fit an Ethernet-like
> aggregation model. Which destroys the can_ml_priv.
I noticed the "bonding" aspect, but I haven't yet delved deeply into
understanding why a vxcan interface cannot be enslaved to a bonding
net dev. After testing your patch, I observed that sockets previously
bound to the bonding net dev are no longer bound to that bonding net dev.

BR,
Edward


