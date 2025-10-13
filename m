Return-Path: <linux-can+bounces-5142-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BF7BD1E4F
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 09:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8723BB36C
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 07:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18E72EAD0A;
	Mon, 13 Oct 2025 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=commetrax.com header.i=@commetrax.com header.b="jIX8+oeN"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.commetrax.com (mail.commetrax.com [141.95.18.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F62EAB99
	for <linux-can@vger.kernel.org>; Mon, 13 Oct 2025 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.18.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342216; cv=none; b=XgF/kyQEYBipQUQcisYDXNjaNpbVj8ce2LNGCbrFgZumj0VOW1nK5zsbmmdMpiTyfrjWPhYl4H//V3qanHrlWaHSJFEaK7HadvmyccIkLRS+pGxZ3JzoHR+5BEwZfSGm0dooQYosMMO3E9K2wZ29SBDa0zmf5v30P3LVtE41XXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342216; c=relaxed/simple;
	bh=M2z+nFeXqIRcbI6rcgrOtIQjqLLid9ZQ1XheJsIeFLM=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=e0198pS7++p0FbM5SjCXx909z/tWHPn+LArBfZBfeySSNpEtYeipRyKszikKaUQ4h7jL7jolv0YsqBDnWVxdHHbb2yjXnta2BLHSy48mbWS8lErbdEckCR6hnq8FUWa5XNPkDGR8Lni9QBcpfynbJsVfcVd06wJ8IEEL6HhC/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commetrax.com; spf=pass smtp.mailfrom=commetrax.com; dkim=pass (2048-bit key) header.d=commetrax.com header.i=@commetrax.com header.b=jIX8+oeN; arc=none smtp.client-ip=141.95.18.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commetrax.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commetrax.com
Received: by mail.commetrax.com (Postfix, from userid 1002)
	id 0F1A223909; Mon, 13 Oct 2025 09:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commetrax.com;
	s=mail; t=1760342213;
	bh=M2z+nFeXqIRcbI6rcgrOtIQjqLLid9ZQ1XheJsIeFLM=;
	h=Date:From:To:Subject:From;
	b=jIX8+oeNGuF4TKlSdzFzFIXbUMpuCNsp0AhFztEkENjijVFOmq4voiALbHZP6waSO
	 yl5QhklXRvxL8YYoKCSxt61cmBB+SC6Nklu7WCV6V8j2oo1JXYGCASDlA9/ErMO9NZ
	 RYQ94x8KlnkFUow1jclDVQvM7Xc3RLUTklmrS2HZAlK3GcTuWz3gD3kfP4xEYVnG+6
	 ff346T6neDYBWFfpipR9zfmfrp5aoemzDXFUdT1zhoHqc4Z8QVQwm6JN8dT0G4t61e
	 5D33+1EjjmLGXa2jDGZV9mT/wnsoQZ4yZS9Gas+tYsnStvM2w7GNZ2HjitdZJOpYUa
	 9AClhJ9bX7xoA==
Received: by mail.commetrax.com for <linux-can@vger.kernel.org>; Mon, 13 Oct 2025 07:55:41 GMT
Message-ID: <20251013084500-0.1.c8.16dxz.0.nf28fg4vqg@commetrax.com>
Date: Mon, 13 Oct 2025 07:55:41 GMT
From: "Luke Walsh" <luke.walsh@commetrax.com>
To: <linux-can@vger.kernel.org>
Subject: Welders ready to work
X-Mailer: mail.commetrax.com
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

we support companies in carrying out industrial projects by providing wel=
ding and assembly of steel structures =E2=80=93 both on-site and in-house=
=2E

In practice, this means we enter with a ready team of welders and fitters=
, take responsibility for preparing the components, their installation an=
d quality control.=20

The client receives a complete, safe and timely delivered structure.

If you have projects that require steel solutions, we would be happy to t=
alk about how we can take over this part of the work and relieve your tea=
m.

Would you be open to a short conversation?


Best regards
Luke Walsh

