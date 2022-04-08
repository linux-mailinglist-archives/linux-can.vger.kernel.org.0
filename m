Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3452E4F9F1C
	for <lists+linux-can@lfdr.de>; Fri,  8 Apr 2022 23:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiDHVYz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Apr 2022 17:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiDHVYv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Apr 2022 17:24:51 -0400
Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 103706BDF5
        for <linux-can@vger.kernel.org>; Fri,  8 Apr 2022 14:22:45 -0700 (PDT)
Received: from localhost.localdomain ([93.35.164.10])
        by Aruba Outgoing Smtp  with ESMTPSA
        id cw44niqt779nYcw44nG1Vt; Fri, 08 Apr 2022 23:22:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1649452964; bh=LVsltK9iEcTGK7OSkzv3VRUP3DRRbW6AQt/m9+GMyVk=;
        h=From:To:Subject:Date:MIME-Version;
        b=Eg9/XEE3sNHjLyol2bBtHtzuiBNYWf4DGImP4JM8Cddfc5//S+Bw85BYxg0fIaqt9
         Uxjw9Kak9rIA6G4I3VRl3qT58l4ZACRIBcQAq5kCUv4900pRJkc4ZzvObffRY6x8Xt
         pVL70iGtkK9ys90WoLwF4TtMhzvy8Q14Qz3djuQWsxAuv+rei9LEedUnfGZMp7WqqN
         pW0Mt4ooqp/AJWzkkD+8qki5BYKGmQxc6waH4i7326MJaRmrwp2stWd0mhpGQjlfoV
         kD5PAzsyLR7eo57I8/T2hhnh5TX/dBtNXhO30cep6s29ScSSWtLvwf8nStZ/EU1Tws
         AJVjGYmgG8gcQ==
From:   Devid Antonio Filoni <devid.filoni@egluetechnologies.com>
To:     Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        Devid Antonio Filoni <devid.filoni@egluetechnologies.com>
Subject: [PATCH] can: j1939: do not wait 250ms if the same addr was already claimed
Date:   Fri,  8 Apr 2022 23:22:37 +0200
Message-Id: <20220408212237.17065-1-devid.filoni@egluetechnologies.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFgMq97427GjGGxs+STj3FT3Ek9ifsU/P1aTQNIBiYja41JQKjwGYa1uUhsVWblCYWIdhTmGHxOJR3L0qc8+JLfHu3Cn+9uvclWJrDDcq/ADLdSaRvBs
 NpwdOWVTvPwUaI3hhkZ51jc9CkRZU/ksALoun2/T6a/MfN9Cy/4nC4jN3f8NtNBwr7e+4Lk0kh+e992VnHNgBXvgfazlZCizDBZ3XZmeTcgd5fOVgnFsOTf6
 sNqPGHjapb/AY7bP8zYDwMzsObP2chgRWwGHHh7BwFyMqzOuyhWr4LV3EjN/pzgjoi/ecKK+c1GiF+67ZyNANtl2nhZF6kLgmXeAq2lVu9fsNxTWsEBYTdFE
 mldiw3GJN7RoiBJnA15rpPLfiiDsrw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is not explicitly stated in SAE J1939-21 and some tools used for
ISO-11783 certification do not expect this wait.

Fixes: 9d71dd0 ("can: add support of SAE J1939 protocol")
Signed-off-by: Devid Antonio Filoni <devid.filoni@egluetechnologies.com>
---
 net/can/j1939/address-claim.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/can/j1939/address-claim.c b/net/can/j1939/address-claim.c
index f33c47327927..1d070c08edf1 100644
--- a/net/can/j1939/address-claim.c
+++ b/net/can/j1939/address-claim.c
@@ -165,6 +165,12 @@ static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
 	 * leaving this function.
 	 */
 	ecu = j1939_ecu_get_by_name_locked(priv, name);
+
+	if (ecu && ecu->addr == skcb->addr.sa) {
+		/* the address was already claimed with the same name, nothing to do */
+		goto out_ecu_put;
+	}
+
 	if (!ecu && j1939_address_is_unicast(skcb->addr.sa))
 		ecu = j1939_ecu_create_locked(priv, name);
 
-- 
2.25.1

