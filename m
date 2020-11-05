Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA5E2A8A16
	for <lists+linux-can@lfdr.de>; Thu,  5 Nov 2020 23:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgKEWu0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Nov 2020 17:50:26 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:49078 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEWu0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Nov 2020 17:50:26 -0500
Date:   Thu, 05 Nov 2020 22:50:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acoro.eu;
        s=protonmail; t=1604616623;
        bh=RvinistVhbR66dxOy8t9p1i0zRbCOLWYXHYXiMmSI24=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=owH5Za/dNpD4tXVo9bGhofJQlzVDW8yw44Tv4lRnxzQzXzTDfwrFhnp3nYjnP2pWT
         lOmzdNzMXU7PnNQN6Z9JhwAlm/9KzZTh4soNO5Svy4W4e8/XSMInuYcuUQFA9nFPw/
         EjqGcHwS4cYy6C19hJsfKfD6Oan1W7DqSbsrw4ZO+JoutwuLmnV0NqgTLiYJympuO6
         pXFHUVc86aDlhdYJvHnAFJ/vBFhU3B/iS15alZkGt0Is6fzY7BSj0vbAvjLjQvJ3FX
         JJoFiAcsLfg+4+enMG54sj++uODAPcei31TtvE0lSuFoas5QUPJGjOCzOfeBx4yF0d
         PbXeuN4A7zdMQ==
To:     linux-can@vger.kernel.org, mkl@pengutronix.de
From:   Alejandro <alejandro@acoro.eu>
Cc:     wg@grandegger.com, davem@davemloft.net, kuba@kernel.org
Reply-To: Alejandro <alejandro@acoro.eu>
Subject: [PATCH] can: dev: can_restart(): post buffer from the right context
Message-ID: <c5a4c85c-ebaf-36d8-0a4b-a3d430c2eaba@acoro.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Alejandro Concepcion Rodriguez <alejandro@acoro.eu>

netif_rx() is meant to be called from interrupt contexts. can_restart()
may be called by can_restart_work(), which is called from a worqueue, so
it may run in process context. Use netif_rx_any_context() which invokes
the correct code path depending on context.

Co-developed-by: Loris Fauster <loris.fauster@ttcontrol.com>
Signed-off-by: Loris Fauster <loris.fauster@ttcontrol.com>
Signed-off-by: Alejandro Concepcion Rodriguez <alejandro@acoro.eu>
---
  drivers/net/can/dev.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index b70ded3760f2..83114f8e8c24 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -584,7 +584,7 @@ static void can_restart(struct net_device *dev)
 =20
  =09cf->can_id |=3D CAN_ERR_RESTARTED;
 =20
-=09netif_rx(skb);
+=09netif_rx_any_context(skb);
 =20
  =09stats->rx_packets++;
  =09stats->rx_bytes +=3D cf->can_dlc;
--=20
2.17.1


