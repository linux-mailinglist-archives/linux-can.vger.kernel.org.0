Return-Path: <linux-can+bounces-403-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE7B87E7AE
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 11:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C361C20404
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 10:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9955C2E652;
	Mon, 18 Mar 2024 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="G/hLctTb";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+j3CGnzl"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BB32E651
	for <linux-can@vger.kernel.org>; Mon, 18 Mar 2024 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759012; cv=pass; b=ZKmEe7vaQrs65dlhI1a/wpIllUNFsPFMzVg7T4tQIwhF0xiNH7sgoJbf5MHl08eAgMNFzk+ECwnPMNbNmd1cS/zq/cnf1wXHa/v7ks3FEkwwhTxPQ/MhLuNmHaF9thRknurSmD6+0dorubLUZH33JagOmu9Amj0SFArLrrIhvfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759012; c=relaxed/simple;
	bh=tT/1d2FBsbrLQQD0JShlmQ3F2plw4Gkeu9BiR2vCCo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jfJMQbodB3pFwAM/V5bzWIbjkwZRmsSXLSXEPddIYlqy8hOUomWMP6qe70DqDwrO7obLL//MAN5dXQpwsjsByRZW8u4K+n40rYqFT8z/x0a65nmQi7HeFOpskUlrqx4M24G8wXTVsLXSY9QGEIi47y26y9KWGJaK2qlzyYSZ++M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=G/hLctTb; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+j3CGnzl; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1710758828; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=loOpyCNv+oeCnFZM/5dpEaSw7JIAVJ4m7Eow4/nf5TYqEzjmU31KUycbNzqVGJhlah
    kdb57a8JG3+GAr/5LWGgWOElIn+n8SfRjx/vLrfoLzGFCKK//dOks8Gs4V2Ga1CpRgeA
    ypflGz8TzWT7+duGo8j87BKRknlLTZ6kzJmqWrnLG/Cw6Oa0nf1+/IgvKXEAqegfusJs
    0haz0cRupbJvD0bL/Ru/ctZZyKEfhvBCYdNloK5LQVDLJ3lpTRdYV+rj2He4V6PGEAiX
    MW5H+5F6BGnbsh/A4Ve8aAEshIJS7nXud59Ywm6qac05ORhgKBzqegSwZeGPsroCHdyE
    VQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710758828;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xyZiyjFO7E/0dR6NM/fR7cybdmKEYvVuwpYlv4JlFbg=;
    b=YgJef3ZxT/pSopcR+jVB1WbmfT+z78WnVQnsktwomspPBoKNujF6uyoImn1Qq8ZOa/
    y//aJKQdZMcq0NfxiAmG9A2K0/Io1R39FVGIGLmS5wKnEMr+v3hsX/lTJbMxV7+H8IkA
    DWbx4mZt6s7OrQCv+Ea9FH6o1f2H6GSNonytIth4narHS3R9D/+KliSXhAGY8ZOfdk1M
    9eD2JEnUTfO+T4gtCdjCywb18MHyHpaoSs+/WXFQ6c3GJi0E1YIeD0w0CnqlJp8XHh0q
    ZhxexIZl3yEj88xcpf52JOJjQ+7i/WrgUfwvNEw+Do3w7TBgqDSgkoJrf6BtjzdJV1AR
    K4nA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710758828;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xyZiyjFO7E/0dR6NM/fR7cybdmKEYvVuwpYlv4JlFbg=;
    b=G/hLctTbC8s5GJmRjWF3bmBFlOGSY+D5cg4wLO31vPXf0x5s/aYb/EFrYglgj1oXGd
    iTJdUeAHxB0EoCoad5g5tZE6fBPU0hCjkd2VoVlWvZtTVe7zx3+AO8A1JbfPZytdeRRK
    TBWQoSOoQXkJ8diFPC1mo73BL5ig6BvYvKfOFuhgstZTZ88tT4U1WGV8UshY4ed+yB2j
    9Y+qnDexPpKqXX4XC4F/+Kn8P0wEcjg7NPy19Bi0gC0KFUGC/x0sQ+RKoB9EhwO9Qns1
    DSXmQgj6ZiScZVcPfzcNBxcZT7fuzuqfEMnEKQ7NLD2DblwSWjeoBJfgvR9LCeXQ8q5V
    btUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710758828;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xyZiyjFO7E/0dR6NM/fR7cybdmKEYvVuwpYlv4JlFbg=;
    b=+j3CGnzlTo571qOBBmrM+efW315h5XOMcik1Kn13HJL+zijtguCNQNVIqZ8ben/NpJ
    90KEAs4uzxRdGMRRu8CQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfhbrd"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 50.2.2 AUTH)
    with ESMTPSA id K0cc6102IAl88To
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 18 Mar 2024 11:47:08 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Guy Harris <gharris@sonic.net>
Cc: wireshark-dev@wireshark.org,
	linux-can@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 0/4] Wireshark SocketCAN updates
Date: Mon, 18 Mar 2024 11:46:39 +0100
Message-ID: <20240318104643.24098-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This patchset simplifies the CAN packet type detection as it focusses
on the rules to distiguish the different CAN CC/FD/XL frames from the
Linux kernel API.

Additionally some more content is shown in the dissector and the
CAN CiA 611-1 definitions have been cleaned up and extended by CiA.

Oliver Hartkopp (4):
  socketcan: simplify CAN packet type detection
  socketcan: display CANFD_FDF and CANXL_XLF flag content
  socketcan: display len8dlc content for Classical CAN
  socketcan: update CAN CiA 611-1 definitions

 epan/dissectors/packet-socketcan.c | 86 ++++++++++--------------------
 epan/dissectors/packet-socketcan.h | 17 +++---
 2 files changed, 39 insertions(+), 64 deletions(-)

-- 
2.43.0


