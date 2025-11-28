Return-Path: <linux-can+bounces-5762-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34230C91922
	for <lists+linux-can@lfdr.de>; Fri, 28 Nov 2025 11:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDFE3A922C
	for <lists+linux-can@lfdr.de>; Fri, 28 Nov 2025 10:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CED13093C3;
	Fri, 28 Nov 2025 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YDibelj0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Cj1IbLv8"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39DA3093BC;
	Fri, 28 Nov 2025 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764324525; cv=pass; b=BfaHn1z3Lfkb+OdIYLcvwtkQCqnOfFmGiobqyZWIxlD5kRkg5Sih1O9FWHChOByNSBawqwRlaANZUMjEjL5GXp97kyq1AHaDCg5brYF2BAVKkavOqxQeM7B5e6VOj0EnWMAaSEAsDskL7STJnKg2T8CpxodHt7IVWiR+FSSuXcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764324525; c=relaxed/simple;
	bh=BDhEwiNMvCsw1e+L7fXg3zof9WO0GC2k06hQKyCEx9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HwXM9BTyyfpKaYjSXvQTGYdOEm6A5quLnfqf9zifrQsJU83d9e+h29DiePNbtdIUxWzZWumvrJDaAfo1vhMa54o6/JZuzt3qyUxpalmNmVUO8GXCKaV2MVnlUPrTbRjq2OewS4nPhkLMiBdwDI2Iqi/zpPi6Lv9muD3zonfnyz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YDibelj0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Cj1IbLv8; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764324500; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WPuDPTAAaGNs9zYPGFpcH74HY1MLff7ZVlEzyFMWVCDipRdQHuFBkg5E3rFTWKKX6y
    Gla46LbET/Mt98jjOaRLS6QFlDo8XBZ/dY62IQRZZ9SFJmb1z6bCsN0nKzITMbSsqzhZ
    ZtEZRzaVlIBikdDTBupAvVBHtUQUCSU2YOvauBl8Ck36j5jPPVBWOEi8SfdkjBeeVPcd
    RTXJS5P5V3ha2t3hcJn5brO1aGjSnduy/z30Ygldni2jMAiAlDQTk7X6DJLwjvaclIfp
    EzE5Ir4yVxtP7NVmi4hd965sFyqZEZW6gVF4IGPK5NjOnsRpzGZCr08uNRqmlsod1bwB
    sDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764324500;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=OFpluY9Z9z4FiIIa1eg7NoQirZeau3C11jdEeP4BnBE=;
    b=Yx2X/V6p2wU1oECF6W3cHqpKE0cMUt90LsY7C87yVebCeeWl4mU4gvXtJ8cgg2FxUu
    ilOvXE2AVPZUNDCqtWeFThXEgBFdycJkqRSLWoWXPYE+TTs1OkNVuZEwoJ9ixqjO/kmn
    ML1XjNaXYNAn7EcQdLjhVEgAOipukPZ9NB7wNDKDjw9BWHa19LD/OZSHlRyhTYr6e0mA
    sMnUyP6rZlaANxtSl0Dqxr0AMU6ZZAH5N9cywfPa51mmJdTKmgSGeYV+fZI2J6IV97xe
    le3/cVcQ3UsH/aaWP7YWq5wjoJgKcndFknygdhWImuzod2jaQ5wMjU+izLaUota2JSFB
    w7eg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764324500;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=OFpluY9Z9z4FiIIa1eg7NoQirZeau3C11jdEeP4BnBE=;
    b=YDibelj0MtAie0CVzSsk3OvWVIsrIJupQ/wju3gFsSkz2IqLZ7TG9aG7jM6luGdH27
    FlElBpILwS8YDOWCRuAnuAkT5JK1FWqKFX83oR6PjRvH3oc5RwpQOhjeR8eHViSx3JVa
    Evt6t2oD4kGsQfs980aVY0Kf7DNHjEKbPBrE9sc2Dd9wpGleSrEL3cGrpCF0N2Z0dvAm
    NyyqwS3yCdxDv2vOsMDQNpJ9ftruiuPkQdDSNUFLhtXVrhSIfDmVmuw1ME6oxK/zBfUi
    xB/t8DLpQh1mzUBJ4TgAI02vTUrAqB5E3UgJTS4OrOkuyv/H6S/KXwJF0lvBerylN5Ic
    5PVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764324500;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=OFpluY9Z9z4FiIIa1eg7NoQirZeau3C11jdEeP4BnBE=;
    b=Cj1IbLv8y/XqktDDrpWpip8CSqgS7xbrSKywZN2mdvqRvzw4oVz+oGYc741rcE2oVb
    4+h/Y/TalbunG+a7hRAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ASA8KesL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 28 Nov 2025 11:08:20 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	kernel@pengutronix.de,
	mkl@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [can-next] can: Kconfig: select CAN driver infrastructure by default
Date: Fri, 28 Nov 2025 11:08:03 +0100
Message-ID: <20251128100803.65707-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The CAN bus support enabled with CONFIG_CAN provides a socket-based
access to CAN interfaces. With the introduction of the latest CAN protocol
CAN XL additional configuration status information needs to be exposed to
the network layer than formerly provided by standard Linux network drivers.

This requires the CAN driver infrastructure to be selected by default.
As the CAN network layer can only operate on CAN interfaces anyway all
distributions and common default configs enable at least one CAN driver.

So selecting CONFIG_CAN_DEV when CONFIG_CAN is selected by the user has
no effect on established configurations but solves potential build issues
when CONFIG_CAN[_XXX]=y is set together with CANFIG_CAN_DEV=m

Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
Reported-by: Vincent Mailhol <mailhol@kernel.org>
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/Kconfig b/net/can/Kconfig
index af64a6f76458..e4ccf731a24c 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -3,10 +3,11 @@
 # Controller Area Network (CAN) network layer core configuration
 #
 
 menuconfig CAN
 	tristate "CAN bus subsystem support"
+	select CAN_DEV
 	help
 	  Controller Area Network (CAN) is a slow (up to 1Mbit/s) serial
 	  communications protocol. Development of the CAN bus started in
 	  1983 at Robert Bosch GmbH, and the protocol was officially
 	  released in 1986. The CAN bus was originally mainly for automotive,
-- 
2.47.3


