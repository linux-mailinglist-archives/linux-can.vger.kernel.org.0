Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D337A7476
	for <lists+linux-can@lfdr.de>; Wed, 20 Sep 2023 09:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjITHmt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Sep 2023 03:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjITHms (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Sep 2023 03:42:48 -0400
X-Greylist: delayed 390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Sep 2023 00:42:43 PDT
Received: from mail.venturelinkage.com (mail.venturelinkage.com [80.211.143.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3F39E
        for <linux-can@vger.kernel.org>; Wed, 20 Sep 2023 00:42:43 -0700 (PDT)
Received: by mail.venturelinkage.com (Postfix, from userid 1002)
        id 55BB4826B8; Wed, 20 Sep 2023 09:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=venturelinkage.com;
        s=mail; t=1695195372;
        bh=7iowqdzve/IIiUUjcEwx8j3uMrVqqiE7R9zbOCKRV9Q=;
        h=Date:From:To:Subject:From;
        b=mu6EiNFXRdGhdo7v91OPdOeqBcEp7jo1FOwS7aya3600M3uP2h5Kncj7fmczA5j9L
         B1xkqpcwCcrkhpeThbw4/7qRgEJ8qh3mLtDg+PJ/jm29IVYzKQS78WrZu6ZH6eNYTb
         SwhAfVng8qlK3hNjFi1Gvm/RoRzXYojWw/Asaob461fiisNjuek7eyiAmHR9ErAE1B
         0a9QfDrBqdZzRMkoBp2UcugF35YaS68HriUW+6UXCpnvtaH5nJY8IpkCRoa4XmzSug
         Qg2Br4NqvDVYAJLY9rtrBS1zO49REZSpn1p6uE6tvXtaMvIdI8TdsvvsRw3pkvKZL0
         4b9xPm9j7S4Cg==
Received: by mail.venturelinkage.com for <linux-can@vger.kernel.org>; Wed, 20 Sep 2023 07:36:09 GMT
Message-ID: <20230920084500-0.1.l.11ar.0.bn6w3k9khf@venturelinkage.com>
Date:   Wed, 20 Sep 2023 07:36:09 GMT
From:   "Lukas Varga" <lukas.varga@venturelinkage.com>
To:     <linux-can@vger.kernel.org>
Subject: =?UTF-8?Q?Popt=C3=A1vka?=
X-Mailer: mail.venturelinkage.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM28,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: venturelinkage.com]
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [80.211.143.151 listed in list.dnswl.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [80.211.143.151 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: venturelinkage.com]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0656]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.8 FROM_FMBLA_NEWDOM28 From domain was registered in last 14-28
        *      days
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dobr=C3=A9 r=C3=A1no,

Dovolil jsem si V=C3=A1s kontaktovat, proto=C5=BEe m=C3=A1m z=C3=A1jem ov=
=C4=9B=C5=99it mo=C5=BEnost nav=C3=A1z=C3=A1n=C3=AD spolupr=C3=A1ce.

Podporujeme firmy p=C5=99i z=C3=ADsk=C3=A1v=C3=A1n=C3=AD nov=C3=BDch obch=
odn=C3=ADch z=C3=A1kazn=C3=ADk=C5=AF.

M=C5=AF=C5=BEeme si promluvit a poskytnout podrobnosti?

V p=C5=99=C3=ADpad=C4=9B z=C3=A1jmu V=C3=A1s bude kontaktovat n=C3=A1=C5=A1=
 anglicky mluv=C3=ADc=C3=AD z=C3=A1stupce.


Pozdravy
Lukas Varga
