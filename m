Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15EF518F0E8
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2020 09:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgCWIeD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 23 Mar 2020 04:34:03 -0400
Received: from mail-eopbgr30069.outbound.protection.outlook.com ([40.107.3.69]:49280
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727534AbgCWIeC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 23 Mar 2020 04:34:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgVL8K8aOlytZfW5in/6UiUHdUmxuj3PM+t8fDx7MlnoFlRoox1fNuKadgs9La4Tc5kMmuHpgwJ5ILPMSiE96rlwoqNzgmKTA4rfPvnMdYOYmZdEqE9R6oPTN8u3DBD8p6nSGyPv4i34drlqhYGFBL0/+Hc8kjyjjZUs7VidfLL1yObA2nqCT3g93G0vGpJf0WQvakB6Lev0cvtzRsPn/21Do+YYXvM0LOnlNYYXPUymr0d0dtic6DBFIKeW+b4ecE4z9Vt5FlwVIl/4mfswafQAjEVpBdx9nY9y03Ccn//9vkiZNb7JXKcWjVFDeq6jnIU/875z/yPSSBDqwco/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pceo94clXRU9cgvOqeZHFrxHZlCZoB3QH2osYCbIhwM=;
 b=EexLC/pQ/GSL4D53CUmUfpzEln7MtjOeWsQYaSQAapDjixsGAU435ejOn2MXnI0afMU5PU1gKvSob/RJtWil4KxuY19m9bG2PXsrxUYkmyXVPBpLbgyIaHVivX9AP+HAkYkrFx5LlKnLM5f6+r9ha5wA5aEH+z3whWrC0bxi4gIyJ1t24Pu/HY2KHptURCcTz1S9AsKP5EaMMX4uD5P7n3J0I4LbcyNkWAIPWfDuKbMt0DlmIrXvls+HBB8VfYsR0yhdPENuOdP55Zyzjr2P0qoUfqi3+36oVs6UsW7qQqvnXiqY9zvaMEazYpoPKdXe7oNTDFwss0/XghDoMvd5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pceo94clXRU9cgvOqeZHFrxHZlCZoB3QH2osYCbIhwM=;
 b=FYwp4JawwaJQ01sXzscAQGZ/eYQFhxFwLw2KNZcb1iC17Tkrrv6nhAVjtJ2grHpoQwC+7Tiws4JuSgPBpuIzPVLReziGEcMcIev8nf23wbXQyGCMyLCksAqdiW1IKSKd3rHqcCn0lS5QeF2eeQqwuBj5NAkYaOw19WInr6dZkus=
Received: from DB6PR03MB3093.eurprd03.prod.outlook.com (10.165.163.10) by
 DB6PR03MB2903.eurprd03.prod.outlook.com (10.165.186.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Mon, 23 Mar 2020 08:33:56 +0000
Received: from DB6PR03MB3093.eurprd03.prod.outlook.com
 ([fe80::9c30:9ea5:1f62:3eb1]) by DB6PR03MB3093.eurprd03.prod.outlook.com
 ([fe80::9c30:9ea5:1f62:3eb1%6]) with mapi id 15.20.2835.017; Mon, 23 Mar 2020
 08:33:56 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: PCI/PCIe cards and MSI support
Thread-Topic: PCI/PCIe cards and MSI support
Thread-Index: AQHV/do29lzRw5ZU0EO1t7ZGglOftKhP8g+AgAXsB9Y=
Date:   Mon, 23 Mar 2020 08:33:56 +0000
Message-ID: <DB6PR03MB3093B3487EC5FCFBFCDB4D6AD6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>
References: <DB6PR03MB3093A117F99170BDD81CBC1FD6F40@DB6PR03MB3093.eurprd03.prod.outlook.com>,<20200319140127.GD2538@x1.vandijck-laurijssen.be>
In-Reply-To: <20200319140127.GD2538@x1.vandijck-laurijssen.be>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=s.grosjean@peak-system.com; 
x-originating-ip: [89.158.154.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 120a7799-2de9-4955-bad2-08d7cf04ed85
x-ms-traffictypediagnostic: DB6PR03MB2903:
x-microsoft-antispam-prvs: <DB6PR03MB290330920F204626056039B8D6F00@DB6PR03MB2903.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(346002)(396003)(366004)(136003)(376002)(199004)(81156014)(8676002)(81166006)(8936002)(71200400001)(9686003)(66574012)(4326008)(86362001)(508600001)(6916009)(186003)(66476007)(316002)(66946007)(64756008)(66556008)(15974865002)(7696005)(33656002)(2906002)(52536014)(5660300002)(66446008)(26005)(76116006)(55016002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR03MB2903;H:DB6PR03MB3093.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: peak-system.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gP5BuKgUJuUW88nc9eSaLAjWccGh7mihpqrbf/By22nvCpTU+kzGny5yEXCRMKfm4P6dLHA5XRuNF/XppMma8cgpAH4qHvs6RfUlOjg1NiZYx/xySC/di43cLG9+tSp5W47z5Z87g3u0xpdELpYzqydL+YGqFCzCEEoot7AiOMGonkwskl/xX0cWjXTmRglnHQTghdPH1bgJN1YxmTj+usZ0G1qQcFF1KPcfBLJLBT0k54nnSuqj+nPcAMduj52i0p6xCZOzHM1OEGe+aJnJzoAWvXjSh6+Eo55mKJt8fUJIoPNDMBKODUgG91HA/zxin+gTldr0Rqx+4VSAeVhYwU1wSDzMk+WJ70iiM9yJb8SlL3qw+eNIWZdPRDC2edl1pCOZT8Q1Nhg7Hr2dVB9MglML3iZW1CDzwcIQT9R0XetcHvdAxYQe6NSwXG27g4IX
x-ms-exchange-antispam-messagedata: isiXctKMvMRM0q0wh6aqeAQI6vIU9nRbhfR6dal7tafBpfIeBM/gg0svbqVHqmGkJnTEBd6AVptE8D+Nz+cq3wJgAHPY7ioHyxefCxS30y+PfSNCWYvQFRPv1hrrJWpRN1QAn3sk5N9EGu762NIWzA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120a7799-2de9-4955-bad2-08d7cf04ed85
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 08:33:56.5858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l3IM7Tn8D911Fo7u+aETffb2G7ryIWGPAfJ6OCmXQ4Nj3Da5TIk2JXIjTa0+zBS+EDvb2bi8E3+gXkYJeIdvqlo4cL2OsenijnJw2T7VZ6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB2903
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Kurt,

Thank you for your reply.

> This seems a bad idea. Loading the module should not allocate resources.
> A reasonable point IMHO is the probe of a device.

That's what I was thinking, sorry for the approximation and misunderstandin=
g. So, you confirm that I can modify the driver to request_irq() when probi=
ng the CAN channels one after the other rather than when these are opened?

Regards,

---
St=E9phane Grosjean
PEAK-System France
132, rue Andr=E9 Bisiaux
F-54320 MAXEVILLE
T=E9l : +(33) 9.72.54.51.97











De : Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

Envoy=E9 : jeudi 19 mars 2020 15:01

=C0 : St=E9phane Grosjean <s.grosjean@peak-system.com>

Cc : linux-can@vger.kernel.org <linux-can@vger.kernel.org>

Objet : Re: PCI/PCIe cards and MSI support




Hey,



> or if the driver can decide to request (resp. free) IRQs when loading (re=
sp. unloading)

> the module?



This seems a bad idea. Loading the module should not allocate resources.

A reasonable point IMHO is the probe of a device.



Kurt


--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
