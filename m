Return-Path: <linux-can+bounces-7660-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBnqOKLJC2pSNQUAu9opvQ
	(envelope-from <linux-can+bounces-7660-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 19 May 2026 04:23:30 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EBA576676
	for <lists+linux-can@lfdr.de>; Tue, 19 May 2026 04:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85AA63007371
	for <lists+linux-can@lfdr.de>; Tue, 19 May 2026 02:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C295831194C;
	Tue, 19 May 2026 02:23:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DFB270575
	for <linux-can@vger.kernel.org>; Tue, 19 May 2026 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779157396; cv=none; b=VNgHpMOLsLXDA5U8GXxKAp2VvhAbjnkazcCoXJqeo7Ya95WY/yzLf0Sv0W5LscfK3l8Enbzmk1ICs+QtT913Tmh0gOxx8lf6epSFvxUYlrG+n+k52t21ExfroIAj7Xp7fsIOlCYvaNwbOmWDk1dr5vtFUtaGIB59yucPIKbgqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779157396; c=relaxed/simple;
	bh=b+UuQr7kjG0oQaE8CpTkSSsNrYUp+abjHnMU/Bi8MSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUzyoXhJNKdXPlYvN+qiPIJenplZCx/b/maPOeir4Tni6ZmHaPpzOhTzm8ym0OP7/O8IHjeyhRjibwjy6IlkDgjzawz/2tOuP0/H29SJhGSTg2IlptAIgV0gqyz7q0BxcDoyrh9Xmsv0UjXXVseu8zyFQsONlkk4mHL//RovOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64J2MlCc052543;
	Tue, 19 May 2026 11:22:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64J2MlE7052540
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 19 May 2026 11:22:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7bdea3af-647f-4301-b9cb-3b8a75dc76a6@I-love.SAKURA.ne.jp>
Date: Tue, 19 May 2026 11:22:44 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] can: j1939: use netdevice_tracker for
 j1939_{priv,session,ecu} tracking
To: Jakub Kicinski <kuba@kernel.org>
Cc: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
References: <c109e9fc-3fb7-4a48-a0bd-a4d7663e7342@I-love.SAKURA.ne.jp>
 <ef62371e-ddd5-4074-b554-410c708ca1cd@I-love.SAKURA.ne.jp>
 <20260518190455.7fe355b4@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260518190455.7fe355b4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonic.nl:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,I-love.SAKURA.ne.jp:mid,hartkopp.net:email,pengutronix.de:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-7660-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 45EBA576676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/05/19 11:04, Jakub Kicinski wrote:
> On Tue, 19 May 2026 10:21:32 +0900 Tetsuo Handa wrote:
>>  net/can/j1939/bus.c        | 2 ++
>>  net/can/j1939/j1939-priv.h | 3 +++
>>  net/can/j1939/main.c       | 8 ++++----
>>  net/can/j1939/transport.c  | 2 ++
> 
> Please follow the address list that get_maintainer produces for you.
> netdev@ is flooded by AI patches already we really don't need more.

scripts/get_maintainer.pl produced the following output.

Robin van der Gracht <robin@protonic.nl> (maintainer:CAN-J1939 NETWORK LAYER)
Oleksij Rempel <o.rempel@pengutronix.de> (maintainer:CAN-J1939 NETWORK LAYER)
kernel@pengutronix.de (reviewer:CAN-J1939 NETWORK LAYER)
Oliver Hartkopp <socketcan@hartkopp.net> (maintainer:CAN NETWORK LAYER)
Marc Kleine-Budde <mkl@pengutronix.de> (maintainer:CAN NETWORK LAYER)
linux-can@vger.kernel.org (open list:CAN-J1939 NETWORK LAYER)
linux-kernel@vger.kernel.org (open list)

Do you mean that I should omit netdev@vger.kernel.org , and use "[PATCH v2]"
so that automated process won't be involved before CAN maintainers send this
patch to netdev@vger.kernel.org ?


