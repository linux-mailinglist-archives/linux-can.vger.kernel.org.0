Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCAD71712D
	for <lists+linux-can@lfdr.de>; Wed, 31 May 2023 01:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjE3XCV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 May 2023 19:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjE3XCV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 May 2023 19:02:21 -0400
X-Greylist: delayed 492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 16:02:19 PDT
Received: from server.neomed.cz (server.neomed.cz [212.67.70.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB53E8
        for <linux-can@vger.kernel.org>; Tue, 30 May 2023 16:02:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by server.neomed.cz (Postfix) with ESMTP id 2A7941C14003
        for <linux-can@vger.kernel.org>; Wed, 31 May 2023 00:53:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at neomed.cz
Received: from server.neomed.cz ([127.0.0.1])
        by localhost (sr2400.neomed.cz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I53VVzK-joMd for <linux-can@vger.kernel.org>;
        Wed, 31 May 2023 00:53:38 +0200 (CEST)
Received: by server.neomed.cz (Postfix, from userid 0)
        id 937AB1C14002; Wed, 31 May 2023 00:53:37 +0200 (CEST)
Message-Id: <20230530225337.937AB1C14002@server.neomed.cz>
Date:   Wed, 31 May 2023 00:53:37 +0200 (CEST)
From:   root@server.neomed.cz (root)
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_80,EMPTY_MESSAGE,
        MISSING_HEADERS,MISSING_SUBJECT,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8701]
        *  1.0 MISSING_HEADERS Missing To: header
        *  0.0 SPF_NONE SPF: sender does not publish an SPF Record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
        *  1.8 MISSING_SUBJECT Missing Subject: header
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

