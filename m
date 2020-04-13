Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691B21A64E6
	for <lists+linux-can@lfdr.de>; Mon, 13 Apr 2020 12:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgDMKCc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Apr 2020 06:02:32 -0400
Received: from gans.gerasiov.net ([78.46.205.176]:53958 "EHLO
        mail.gerasiov.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgDMKCc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Apr 2020 06:02:32 -0400
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 06:02:31 EDT
Received: from fran.gerasiov.net (unknown [178.154.217.48])
        by mail.gerasiov.net (Postfix) with ESMTPSA id D3799FC5EE
        for <linux-can@vger.kernel.org>; Mon, 13 Apr 2020 12:53:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gerasiov.net;
        s=dkim; t=1586771588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3DS4T4hYfSapvggI/bEKHliVxK3w3PGJivp1R8R2hb8=;
        b=aMxNIzIrxQnUjMh93J3ZGcqPe5j107V9D9mDhwHVDj7bmKa9JHeoRFoVvFTedvrbC1cOVI
        g9D2CNFGtgdW/YnBGb4RUKcMdU5iYTN4M0n8nroSVNQHzuBfH1hmiIgqwk6zFKcNxdqwPX
        G+21I+Y7n2ClovkQPMShx0D0P46tw3WkwEt7oBUv1Oe1w1C/HQ27VMgBbbV/60ZNu6myUQ
        +2J6nW4wn8YObX7a4QewxA2vJhqGX2jqOHmQAdr2zu0Dx7SLbPDZDNDYGQZ9B2O+u9DYnT
        XC1aCfbCtcaDGLDokPOUGolqdHUiaZamLNcweEQ8eF8e/r0UkEw78QlrLutLUw==
Date:   Mon, 13 Apr 2020 12:53:04 +0300
From:   Alexander Gerasiov <a@gerasiov.net>
To:     linux-can@vger.kernel.org
Subject: jcat binary name conflict
Message-ID: <20200413125304.3a57fe8d@fran.gerasiov.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-RSpamd-Status: No, score=-3.09
X-Spam-Status: No, score=-6.2 required=7.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,TXREP,
        URIBL_ABUSE_SURBL,URIBL_BLACK bayes=0.0000 autolearn=no
        autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello, there.

I just found conflict in binary name jcat with one from sleuthkit
package: https://bugs.debian.org/956530

I'm going to rename the binary to j1939cat in debian package.
May be you should do the same with it (or even with other j.* tools) in
upstream sources.

-- 
Best regards,
 Alexander Gerasiov

 PGP fingerprint: 04B5 9D90 DF7C C2AB CD49  BAEA CA87 E9E8 2AAC 33F1
