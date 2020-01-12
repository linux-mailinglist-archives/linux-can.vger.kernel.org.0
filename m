Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6523138C0E
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2020 07:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgAMGwJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Jan 2020 01:52:09 -0500
Received: from mail01.vodafone.es ([217.130.24.71]:63166 "EHLO
        mail01.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgAMGwI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2020 01:52:08 -0500
IronPort-SDR: +AbeuBiuT/8YvFkJ1fVAASxe6ItUOYKhCXp09txgQKILWljq39oHV987Nazi1H8nmAAmdgdXpd
 R/hgpn/svqKA==
IronPort-PHdr: =?us-ascii?q?9a23=3AQO6/WB/LDOscWv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B32uocTK2v8tzYMVDF4r011RmVBN6dsawVwLOO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe61+IRSyoAneq8UanZduIbstxx?=
 =?us-ascii?q?XUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohVbBXAygoPG?=
 =?us-ascii?q?4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vy?=
 =?us-ascii?q?iu47ttRRT1jisLMCM3/33Nhcx1jKNXuQyspxtlw47MZ4GVLuBxfr/Dct8DW2?=
 =?us-ascii?q?VBWN9dWjBdAoOgdYQAE+oBMvhdr4bjoVsOsQKyCheqBO/2zTFIgXn20rM60u?=
 =?us-ascii?q?g4Dw7G2hErE9YAvXjIsNn5MaEfWv23wqbV1zXOd/1Y1zfn6IbWcR4vvP6DUq?=
 =?us-ascii?q?5/f8fK1UkiFR/KgkmMpYD5IT+Y0PkGvWiB7+pnUOKik3QppB9tojex3Mcnl4?=
 =?us-ascii?q?nGhoUTylDL6C50x541KsOkSEFle96lHpxQtyeVN4ZtQsMiWHpntzogxrIavp?=
 =?us-ascii?q?67eTIGyJQkxxPGbfGMbouG4gr7WeqPPDt1hmhpdK+xihqu60Ss1OLxWtO63V?=
 =?us-ascii?q?tKqCdOj8PCuWoX1xPJ78iKUv59/kC81jmRzw3T8eREIVwslarcNp4h3qY8lp?=
 =?us-ascii?q?oNvkTHGS/7gED2g7WXdkUg4Oin9eDnbqnpq5OGKY90jRzxPb4gmsy4B+Q3LB?=
 =?us-ascii?q?ICUHaA+eik1b3j+1P2QKlSg/Eoj6XUsorWKdkVq6KlGQNZzIku5wyxAjqmyN?=
 =?us-ascii?q?gYmGMILFNBeBKJlYjpPFTOLejgDfihn1Sjji1rxv7BPr3nDZXANXjDkKz6cr?=
 =?us-ascii?q?lh8UJT1A0zzdVF65JUCbENOOjzVVPptNzEEh85NBS5w+LmCNV7y4MfVnuDDb?=
 =?us-ascii?q?ODP6PUqlKI+O0vLPeWZIMPuzbyNeIl5/jwgn89g1MderOp3ZREIEy/S/BnJV?=
 =?us-ascii?q?iJJHHlhP8fHmoQ+AkzVurnjBuFSzEAXXuqW7MA4WQDBZ6rF8/8QYaiyOiZ0T?=
 =?us-ascii?q?u2BIJRYG9GCVCXG3zAeICNWvNKYyWXdJxPiDsBAICsV4I7nS6psgCyn6JqMu?=
 =?us-ascii?q?fO5Soeurrjz9J+oebUkFcy9monXIymz2iRQjQtzSszTDgs0fUk+RRw?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ETKgA/EhxemCMYgtkUBjMYGgEBAQE?=
 =?us-ascii?q?BAQEBAQMBAQEBEQEBAQICAQEBAYF7AgEBFwEBgS6BTVIgEpNQgU0fg0OLY4E?=
 =?us-ascii?q?Agx4VhggTDIFbDQEBAQEBNQIBAYRATgEXgQ8kOgQNAgMNAQEFAQEBAQEFBAE?=
 =?us-ascii?q?BAhABAQEBAQYNCwYphUqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4M?=
 =?us-ascii?q?EgksBATOFJZc6AY0EDQ0ChR2CQwQKgQmBGiOBNgGMGBqBQT+BIyGCKwgBggG?=
 =?us-ascii?q?CfwESAWyCSIJZBI1CEiGBB4gpmBeCQQR2iUyMAoI3AQ+IAYQxAxCCRQ+BCYg?=
 =?us-ascii?q?DhE6BfaM3V4EMDXpxMxqCJhqBIE8YDYgbji1AgRYQAk+JLoIyAQE?=
X-IPAS-Result: =?us-ascii?q?A2ETKgA/EhxemCMYgtkUBjMYGgEBAQEBAQEBAQMBAQEBE?=
 =?us-ascii?q?QEBAQICAQEBAYF7AgEBFwEBgS6BTVIgEpNQgU0fg0OLY4EAgx4VhggTDIFbD?=
 =?us-ascii?q?QEBAQEBNQIBAYRATgEXgQ8kOgQNAgMNAQEFAQEBAQEFBAEBAhABAQEBAQYNC?=
 =?us-ascii?q?wYphUqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4MEgksBATOFJZc6A?=
 =?us-ascii?q?Y0EDQ0ChR2CQwQKgQmBGiOBNgGMGBqBQT+BIyGCKwgBggGCfwESAWyCSIJZB?=
 =?us-ascii?q?I1CEiGBB4gpmBeCQQR2iUyMAoI3AQ+IAYQxAxCCRQ+BCYgDhE6BfaM3V4EMD?=
 =?us-ascii?q?XpxMxqCJhqBIE8YDYgbji1AgRYQAk+JLoIyAQE?=
X-IronPort-AV: E=Sophos;i="5.69,428,1571695200"; 
   d="scan'208";a="304626279"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 13 Jan 2020 07:52:05 +0100
Received: (qmail 24224 invoked from network); 12 Jan 2020 05:00:20 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-can@vger.kernel.org>; 12 Jan 2020 05:00:20 -0000
Date:   Sun, 12 Jan 2020 06:00:18 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-can@vger.kernel.org
Message-ID: <27520913.460729.1578805219919.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

