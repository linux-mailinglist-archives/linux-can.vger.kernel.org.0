Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBA17255BA
	for <lists+linux-can@lfdr.de>; Wed,  7 Jun 2023 09:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbjFGHcE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Jun 2023 03:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbjFGHbj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Jun 2023 03:31:39 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FCB4226
        for <linux-can@vger.kernel.org>; Wed,  7 Jun 2023 00:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686122841; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oj6jDwScu07x2A1kGaC7eYISUP8I6qoYl8TzaEFLrwFAs+7KB3kbo/nBO2o5utC8m3
    5QG7kUXMbyBfySGbx1cuoHI6IMCjBmblHQa29nOSJH1zM1GwshZKrK8w5NpYiDIPWj1a
    tegBpuLNYCwAtOhR/1lcu2kKz+XeVRydhDaUTPEMqEmcWEMB8sPq1ZY2Loi2TDNmW58R
    fH+Q/1n6b6F4vN+O6FmrdmNb8N5dZDPd55E8zsQcNzMDkwnu3JwzFOKg9ZnzpfHVduBs
    +X4/RQAIc28PsS8/hjffVUKNBUC17Aeb++wTd5DPTH7iXeAv6CGf/zWTcJv59WWkhXbC
    hOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686122841;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=RM673aGmjnu1eqOxn28YXILQ+c1ECcDjZA/VArK2PdA=;
    b=kHNdJ57zfEruxwFzV0TX3L71M+194zlaj99mRr2ShBuwt36ZPjcOMcRWWIzn0Ep+zR
    gNlXoPztM9fqCbfG5RhHdHA87suvz5+9ClZTyURyayyRM3zprqOqHnYUJFr9c25Apduj
    //gPKpfQ02TgosTpkam2hQDlXdeZ1zyjYEHsT0w1MHL6ooQPsc+4BLFb0Nsduy/ixrYp
    iuqHxBP0Q5QIsDu0i4g1qUhGY7gRksziXNbh0AMGLcR2hrFwCjWPv3PbbgkQ/gI9UJij
    lWqvgdVlTf8pvlXb93xsV96fEfnn/XNqM7xyV3DFG7lNfEqMwGKTREE1/6eNFv/Y432v
    +UdQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686122841;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=RM673aGmjnu1eqOxn28YXILQ+c1ECcDjZA/VArK2PdA=;
    b=XW+5HgLIpNiCJMwsDfFfkt4uzoPf1D9wCoS+jtOlqDMs4oFdiklYsjfg4F6c6o8Gfd
    iPi/I/CVQ2ViEybwuvxWaGmtTevLvQ013wIA0k1S9msk0t1XnEeXSHmh1lUpVSdDtVLq
    P09us7gRAyjwTP2uPQW63Yg2QW8FrIyrgKCfN97T7BeqkxXhNcuK8LknTVNWePI25GLV
    NlxMQY7vK7a60pGdMrkonR5h8DnnlIvnwrCDuyDMIDy5iJbTZzYL18YGhwqHPzNIGmKT
    ZXszTNINn+yNi+vc3d6inUOCy2JSNnAeNhm358jW5rxhxJo0mDhHnO4QHLxUTSDmP0kp
    Aakg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686122841;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=RM673aGmjnu1eqOxn28YXILQ+c1ECcDjZA/VArK2PdA=;
    b=xT67kJ9AhuEyt0DnK9I+TqfxDKSP4VwHeD4BHL9V1iVD52FoRCURauaEeUSXu3ew5P
    xZ41etpprEZoLVLxG/Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejudJygjsS+Kjg=="
Received: from silver.lan
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id j4ea2az577RLD8K
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 7 Jun 2023 09:27:21 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Carsten Schmidt <carsten.schmidt-achim@t-online.de>
Subject: [PATCH] can: isotp: isotp_sendmsg(): fix return error fix on TX path
Date:   Wed,  7 Jun 2023 09:27:08 +0200
Message-Id: <20230607072708.38809-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With commit d674a8f123b4 ("can: isotp: isotp_sendmsg(): fix return error
on FC timeout on TX path") the missing correct return value in the case
of a protocol error was introduced.

But the way the error value has been read and sent to the user space does
not follow the common scheme to clear the error after reading which is
provided by the sock_error() function. This leads to an error report at
the following write() attempt although everything should be working.

Fixes: d674a8f123b4 ("can: isotp: isotp_sendmsg(): fix return error on FC timeout on TX path")
Reported-by: Carsten Schmidt <carsten.schmidt-achim@t-online.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 84f9aba02901..ca9d728d6d72 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1110,12 +1110,13 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		/* wait for complete transmission of current pdu */
 		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 		if (err)
 			goto err_event_drop;
 
-		if (sk->sk_err)
-			return -sk->sk_err;
+		err = sock_error(sk);
+		if (err)
+			return err;
 	}
 
 	return size;
 
 err_event_drop:
-- 
2.30.2

