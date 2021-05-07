Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764D337651C
	for <lists+linux-can@lfdr.de>; Fri,  7 May 2021 14:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbhEGMag (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 May 2021 08:30:36 -0400
Received: from lissvexedge02.liebherr.com ([193.27.220.106]:60391 "EHLO
        lissvexedge02.liebherr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233468AbhEGMaf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 May 2021 08:30:35 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=liebherr.com; s=key1e; 
 t=1620390573; bh=0hAqWIm0/BT/wJXjI0NCVcU6I+EWkfdiq24cWh1AKn4=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=ed25519-sha256; b=
 q5LwNFGg5JbTFGjBBHnXV4mS5kdIb/eBOPlTTLnilQK89WjjGR3qBQAktG95bK5QMpg+Nvr1g7/+a0soldeZCQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=liebherr.com; s=key1; t=1620390573; 
 bh=0hAqWIm0/BT/wJXjI0NCVcU6I+EWkfdiq24cWh1AKn4=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=rsa-sha256; b=
 UYVge+vUo+uYd+Dh3oinyJ3LOXhIb3xlutnef0c62sOEt5A13I6LLopv4MgBhj6jqYM5+SdRrh5zZKNFqjWT7YOAKZU630j9w3PuxXVYk6Nh3MG5i1a12rDkfl6yTmKg8HJyEtunzbTzG8iJL9d0qnxREAnPi7HduKUpwqyguU8=
From:   "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>
Subject: Re: [PATCH RFC] can: isotp: isotp_sendmsg(): return error on FC
 timeout on TX path
Thread-Topic: Re: [PATCH RFC] can: isotp: isotp_sendmsg(): return error on FC
 timeout on TX path
Thread-Index: AddDPC2cRhpoPdL8Rke/C4fp6vxbuQ==
Date:   Fri, 7 May 2021 12:29:33 +0000
Message-ID: <e9ebf4ab4b1a431eac24a21ab8379894@liebherr.com>
Accept-Language: de-DE, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

Indeed the first version (with positive value) does not work, but I just te=
sted the V2 of the patch, and work like a charm.
Let me know if I can help to get it integrated

Best regards,

Guillaume=20


